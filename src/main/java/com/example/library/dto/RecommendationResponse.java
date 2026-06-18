package com.example.library.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * GET /api/borrowers/{name}/recommendations 的最終回應結構
 * 同時包含「決策樹分類結果」與「Gemini 生成的推薦書單」，方便前端一次取得完整資訊。
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RecommendationResponse {

    private String borrowerName;
    private long totalBorrows;
    private double maxGenreRatio;
    private String topGenre;
    private String readerType;

    private List<BookRecommendation> recommendations;
}
