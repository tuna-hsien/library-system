package com.example.library.service;

import com.example.library.dto.BookRecommendation;
import com.example.library.dto.ReaderProfile;
import com.example.library.exception.GeminiApiException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 負責與 Google Gemini API 整合的 Service。
 *
 * 流程：
 *   1. 依據 ReaderProfile（決策樹分類結果）動態組裝 Prompt
 *   2. 在 Prompt 中嚴格要求 Gemini 僅回傳 JSON 陣列（不含其他文字）
 *   3. 呼叫 Gemini REST API (generateContent)
 *   4. 解析回傳結果，將文字內容反序列化成 List<BookRecommendation>
 */
@Slf4j
@Service
public class GeminiApiService {

    private final WebClient webClient;
    private final ObjectMapper objectMapper;

    @Value("${gemini.api.key}")
    private String apiKey;

    @Value("${gemini.api.model}")
    private String model;

    @Value("${gemini.api.base-url}")
    private String baseUrl;

    public GeminiApiService(WebClient webClient, ObjectMapper objectMapper) {
        this.webClient = webClient;
        this.objectMapper = objectMapper;
    }

    /**
     * 依據讀者畫像，呼叫 Gemini API 取得個人化推薦書單。
     *
     * @param profile      決策樹計算後的讀者特徵畫像
     * @param existingGenres 系統內現有的書籍類型清單（讓 AI 推薦時盡量落在這些類型內）
     */
    public List<BookRecommendation> getRecommendations(ReaderProfile profile, List<String> existingGenres) {
        String prompt = buildPrompt(profile, existingGenres);
        String rawResponseText = callGeminiApi(prompt);
        return parseRecommendations(rawResponseText);
    }

    /**
     * 組裝給 Gemini 的 Prompt。
     * 將「決策樹分類結果」與「最常借閱類型」當作商務脈絡 (Context) 提供給模型，
     * 並嚴格限制回傳格式為純 JSON 陣列，方便後端直接解析。
     */
    private String buildPrompt(ReaderProfile profile, List<String> existingGenres) {
        String genreList = (existingGenres == null || existingGenres.isEmpty())
                ? "小說、科普、商業、歷史、漫畫"
                : String.join("、", existingGenres);

        return """
                你是一位專業的圖書館選書顧問。請根據以下讀者的借閱行為分析結果，為他推薦書單。

                【讀者借閱行為分析】
                - 借閱者姓名：%s
                - 總借閱次數：%d 次
                - 最常借閱類型：%s
                - 該類型佔總借閱次數比例：%.1f%%
                - 系統決策樹分類結果：%s

                【讀者類型說明】
                - 核心專一讀者：借閱量大且高度集中在單一類型，偏好深入鑽研同類主題
                - 博學探索讀者：借閱量大且類型分散，喜歡廣泛涉獵不同領域
                - 潛力小眾讀者：借閱量不多但偏好集中，是某類型的潛在忠實讀者
                - 隨興體驗讀者：借閱量不多且類型分散，偏好隨興、輕鬆嘗試不同書籍

                【任務】
                請根據此讀者類型與最常借閱類型，推薦 3 到 5 本書籍。
                書籍類型請盡量從以下範圍內挑選：%s。
                每本書請附上一句個人化的推薦理由，需扣合該讀者的類型特性。

                【嚴格輸出格式要求】
                - 只能回傳一個 JSON 陣列，不要包含任何 Markdown 標記（例如 ```json），不要有任何說明文字、前言或結語。
                - JSON 陣列中每個物件需包含以下四個欄位，且 key 名稱必須完全一致：
                  "title"（書名，字串）、"genre"（類型，字串）、"author"（作者，字串，若未知請填 "未知"）、"reason"（推薦理由，字串）
                - 範例格式（僅供格式參考，內容請依實際分析重新生成）：
                [
                  {"title": "範例書名", "genre": "小說", "author": "範例作者", "reason": "範例推薦理由"}
                ]
                """.formatted(
                profile.getBorrowerName(),
                profile.getTotalBorrows(),
                profile.getTopGenre() == null ? "尚無借閱紀錄" : profile.getTopGenre(),
                profile.getMaxGenreRatio() * 100,
                profile.getReaderType(),
                genreList
        );
    }

    /**
     * 呼叫 Gemini generateContent REST API，回傳模型生成的純文字內容。
     * API 文件： https://ai.google.dev/api/generate-content
     */
    private String callGeminiApi(String prompt) {
        String url = baseUrl + "/" + model + ":generateContent?key=" + apiKey;

        Map<String, Object> requestBody = Map.of(
                "contents", List.of(
                        Map.of("parts", List.of(Map.of("text", prompt)))
                ),
                // generationConfig 中明確要求 MIME type 為 application/json，
                // 部分 Gemini 模型支援此參數強制結構化輸出，可進一步降低格式跑掉的風險
                "generationConfig", Map.of(
                        "temperature", 0.7,
                        "responseMimeType", "application/json"
                )
        );

        try {
            String response = webClient.post()
                    .uri(url)
                    .header("Content-Type", "application/json")
                    .bodyValue(requestBody)
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();

            return extractTextFromGeminiResponse(response);

        } catch (Exception e) {
            log.error("呼叫 Gemini API 失敗", e);
            throw new GeminiApiException("無法取得 Gemini 回應：" + e.getMessage(), e);
        }
    }

    /**
     * 從 Gemini 原始回應 JSON 中，取出 candidates[0].content.parts[0].text 的純文字內容。
     */
    private String extractTextFromGeminiResponse(String rawJson) {
        try {
            JsonNode root = objectMapper.readTree(rawJson);
            JsonNode textNode = root.path("candidates")
                    .path(0)
                    .path("content")
                    .path("parts")
                    .path(0)
                    .path("text");

            if (textNode.isMissingNode()) {
                throw new GeminiApiException("Gemini 回應格式不符預期，原始內容：" + rawJson);
            }
            return textNode.asText();

        } catch (GeminiApiException e) {
            throw e;
        } catch (Exception e) {
            throw new GeminiApiException("解析 Gemini 回應外層結構失敗：" + e.getMessage(), e);
        }
    }

    /**
     * 將 Gemini 回傳的純文字（預期為 JSON 陣列字串）反序列化成 List<BookRecommendation>。
     * 即使已在 Prompt 嚴格限制格式，仍額外做一層保護性清理，避免 Markdown code fence 殘留導致解析失敗。
     */
    private List<BookRecommendation> parseRecommendations(String text) {
        String cleaned = text.trim();

        // 防呆：若模型仍包了 ```json ... ``` 區塊，先去除
        if (cleaned.startsWith("```")) {
            cleaned = cleaned.replaceAll("^```json\\s*", "")
                    .replaceAll("^```\\s*", "")
                    .replaceAll("```\\s*$", "")
                    .trim();
        }

        try {
            List<BookRecommendation> result = objectMapper.readValue(
                    cleaned, objectMapper.getTypeFactory().constructCollectionType(List.class, BookRecommendation.class));

            // 過濾掉空物件，避免模型偶爾回傳不完整資料
            return result.stream()
                    .filter(r -> r.getTitle() != null && !r.getTitle().isBlank())
                    .collect(Collectors.toList());

        } catch (Exception e) {
            log.error("解析 Gemini 推薦書單 JSON 失敗，原始文字：{}", cleaned, e);
            throw new GeminiApiException("Gemini 回傳內容非合法 JSON 格式，無法解析推薦書單", e);
        }
    }
}
