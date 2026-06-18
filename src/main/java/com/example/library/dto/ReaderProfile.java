package com.example.library.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

/**
 * 內部使用的讀者特徵畫像 (不直接對外輸出)，
 * 由 ReaderClassificationService 計算後，傳遞給推薦邏輯與 Gemini Prompt 組裝使用。
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReaderProfile {

    private String borrowerName;
    private long totalBorrows;
    private double maxGenreRatio;
    private String topGenre;
    private String readerType;

    /** 各類型借閱次數明細，例如 {"小說": 5, "科普": 3} */
    private Map<String, Long> genreCountMap;
}
