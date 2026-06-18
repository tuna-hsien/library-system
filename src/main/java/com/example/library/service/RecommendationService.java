package com.example.library.service;

import com.example.library.dto.BookRecommendation;
import com.example.library.dto.RecommendationResponse;
import com.example.library.dto.ReaderProfile;
import com.example.library.entity.Book;
import com.example.library.repository.BookRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 整合層 Service：串接「決策樹分類」與「Gemini API 推薦」，
 * 是 GET /api/borrowers/{name}/recommendations 端點背後的主要邏輯。
 */
@Service
@RequiredArgsConstructor
public class RecommendationService {

    private final ReaderClassificationService classificationService;
    private final GeminiApiService geminiApiService;
    private final BookRepository bookRepository;

    public RecommendationResponse recommendFor(String borrowerName) {

        // ---------- 1. 執行決策樹計算，取得讀者類型標籤與最常借閱類型 ----------
        ReaderProfile profile = classificationService.classify(borrowerName);

        // ---------- 2. 取得系統內現有書籍的類型清單，作為 Gemini Prompt 的限定範圍參考 ----------
        List<String> existingGenres = bookRepository.findAll().stream()
                .map(Book::getGenre)
                .distinct()
                .collect(Collectors.toList());

        // ---------- 3. 呼叫 Gemini API，依讀者畫像生成推薦書單 ----------
        List<BookRecommendation> recommendations = geminiApiService.getRecommendations(profile, existingGenres);

        // ---------- 4. 將 Gemini 推薦結果與系統現有書籍比對，標記是否已存在館藏 ----------
        markExistenceInLibrary(recommendations);

        return RecommendationResponse.builder()
                .borrowerName(profile.getBorrowerName())
                .totalBorrows(profile.getTotalBorrows())
                .maxGenreRatio(profile.getMaxGenreRatio())
                .topGenre(profile.getTopGenre())
                .readerType(profile.getReaderType())
                .recommendations(recommendations)
                .build();
    }

    /**
     * 將 Gemini 推薦的書籍與系統現有 books 表比對（以書名為比對基準，忽略大小寫與前後空白），
     * 並在每筆推薦結果中標記 existsInLibrary，方便前端區分「館藏內可直接借閱」與「館藏外建議採購」。
     */
    private void markExistenceInLibrary(List<BookRecommendation> recommendations) {
        Set<String> existingTitles = bookRepository.findAll().stream()
                .map(b -> b.getTitle().trim().toLowerCase())
                .collect(Collectors.toSet());

        for (BookRecommendation rec : recommendations) {
            boolean exists = rec.getTitle() != null
                    && existingTitles.contains(rec.getTitle().trim().toLowerCase());
            rec.setExistsInLibrary(exists);
        }
    }
}
