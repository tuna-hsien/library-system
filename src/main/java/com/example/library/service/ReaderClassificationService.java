package com.example.library.service;

import com.example.library.dto.ReaderProfile;
import com.example.library.repository.BorrowRecordRepository;
import com.example.library.repository.BorrowRecordRepository.GenreCountProjection;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * ============================================================
 *  核心商務邏輯：決策樹分類 (Decision Tree Classification)
 * ============================================================
 *
 * 本服務負責：
 *   1. 透過 Repository 的 SQL 聚合查詢，取得借閱者「各類型借閱次數」明細
 *   2. 計算兩項特徵：總借閱次數 (total_borrows)、單一類型佔比 (max_genre_ratio)
 *   3. 以「多層 if-else 分支」(而非單一 if) 進行決策樹分類，產出四種閱讀者類型標籤
 *
 * 決策樹結構（兩層、四個葉節點）：
 *
 *                         [Root] 總借閱次數 >= 10 ?
 *                        /                          \
 *                     是                              否
 *                      |                               |
 *         單一類型佔比 >= 70% ?              單一類型佔比 >= 70% ?
 *           /             \                     /             \
 *         是               否                 是               否
 *          |                |                  |                |
 *    核心專一讀者      博學探索讀者        潛力小眾讀者      隨興體驗讀者
 *   (CORE_FOCUSED)    (EXPLORER)         (NICHE_POTENTIAL)   (CASUAL)
 */
@Service
@RequiredArgsConstructor
public class ReaderClassificationService {

    /** 決策樹第一層分支門檻：總借閱次數 */
    private static final long TOTAL_BORROWS_THRESHOLD = 10L;

    /** 決策樹第二層分支門檻：單一類型佔比 */
    private static final double GENRE_RATIO_THRESHOLD = 0.70;

    private final BorrowRecordRepository borrowRecordRepository;

    /**
     * 計算指定借閱者的特徵畫像，並執行決策樹分類。
     *
     * @param borrowerName 借閱者姓名
     * @return ReaderProfile，包含總借閱次數、最大類型佔比、最常借類型、決策樹分類結果
     */
    public ReaderProfile classify(String borrowerName) {

        // ---------- Step 1：透過 SQL 聚合查詢取得各類型借閱次數 (已由 DB 排序，次數最高者在第一筆) ----------
        List<GenreCountProjection> genreCounts = borrowRecordRepository.countByGenreForBorrower(borrowerName);

        if (genreCounts.isEmpty()) {
            // 查無任何借閱紀錄：視為總次數 0、佔比 0，直接歸類為「隨興體驗讀者」（次數不足且無明顯偏好）
            return ReaderProfile.builder()
                    .borrowerName(borrowerName)
                    .totalBorrows(0L)
                    .maxGenreRatio(0.0)
                    .topGenre(null)
                    .readerType(ReaderType.CASUAL.getLabel())
                    .genreCountMap(Map.of())
                    .build();
        }

        // 保留排序順序（次數高到低），方便除錯與前端顯示
        Map<String, Long> genreCountMap = new LinkedHashMap<>();
        long totalBorrows = 0L;
        for (GenreCountProjection row : genreCounts) {
            genreCountMap.put(row.getGenre(), row.getCnt());
            totalBorrows += row.getCnt();
        }

        // 因查詢已 ORDER BY cnt DESC，第一筆即為借閱次數最高的類型
        GenreCountProjection topRow = genreCounts.get(0);
        String topGenre = topRow.getGenre();
        long topGenreCount = topRow.getCnt();

        // ---------- Step 2：計算特徵二「單一類型佔比」 ----------
        double maxGenreRatio = (double) topGenreCount / totalBorrows;

        // ---------- Step 3：執行多層決策樹分支判斷 ----------
        String readerType = applyDecisionTree(totalBorrows, maxGenreRatio);

        return ReaderProfile.builder()
                .borrowerName(borrowerName)
                .totalBorrows(totalBorrows)
                .maxGenreRatio(maxGenreRatio)
                .topGenre(topGenre)
                .readerType(readerType)
                .genreCountMap(genreCountMap)
                .build();
    }

    /**
     * 決策樹核心分支邏輯。
     *
     * 注意：此處刻意採用「巢狀 if-else」而非單一條件判斷，
     * 用以明確呈現「先依總次數分支，再依佔比分支」的兩層決策樹結構。
     *
     * @param totalBorrows  特徵一：總借閱次數
     * @param maxGenreRatio 特徵二：單一類型佔比 (0.0 ~ 1.0)
     * @return 對應的閱讀者類型標籤文字
     */
    private String applyDecisionTree(long totalBorrows, double maxGenreRatio) {

        // === 第一層分支：總借閱次數是否達到門檻 (>= 10) ===
        if (totalBorrows >= TOTAL_BORROWS_THRESHOLD) {

            // ---- 第二層分支（總次數已達標的分支下）：單一類型佔比是否 >= 70% ----
            if (maxGenreRatio >= GENRE_RATIO_THRESHOLD) {
                // 多且專 → 核心專一讀者
                return ReaderType.CORE_FOCUSED.getLabel();
            } else {
                // 多且廣 → 博學探索讀者
                return ReaderType.EXPLORER.getLabel();
            }

        } else {

            // ---- 第二層分支（總次數未達標的分支下）：單一類型佔比是否 >= 70% ----
            if (maxGenreRatio >= GENRE_RATIO_THRESHOLD) {
                // 少且專 → 潛力小眾讀者
                return ReaderType.NICHE_POTENTIAL.getLabel();
            } else {
                // 少且廣 → 隨興體驗讀者
                return ReaderType.CASUAL.getLabel();
            }
        }
    }
}
