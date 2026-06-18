package com.example.library.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * GET /api/borrowers/{name}/type 的回應結構
 * 包含決策樹計算所需的兩項特徵，以及最終分類結果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReaderTypeResponse {

    private String borrowerName;

    /** 特徵一：總借閱次數 */
    private long totalBorrows;

    /** 特徵二：單一類型佔比 (0.0 ~ 1.0) */
    private double maxGenreRatio;

    /** 該借閱者最常借閱的書籍類型 */
    private String topGenre;

    /** 決策樹分類後的閱讀者類型標籤 */
    private String readerType;
}
