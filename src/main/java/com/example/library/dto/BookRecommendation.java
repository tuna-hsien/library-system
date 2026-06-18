package com.example.library.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 單筆推薦書籍，對應 Gemini 回傳 JSON 陣列中的一個物件。
 * 欄位命名與 Prompt 中要求 Gemini 回傳的 JSON key 一致。
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookRecommendation {

    private String title;

    private String genre;

    private String author;

    @JsonProperty("reason")
    private String reason; // 推薦理由

    /** 是否為系統現有書籍（由後端比對 books 表後填入，非 Gemini 回傳） */
    private Boolean existsInLibrary;
}
