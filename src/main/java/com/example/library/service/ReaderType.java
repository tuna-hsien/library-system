package com.example.library.service;

/**
 * 決策樹分類後的四種閱讀者類型標籤。
 *
 *                總借閱次數 >= 10 ?
 *                   /          \
 *                 是            否
 *                 /              \
 *      佔比 >= 70% ?          佔比 >= 70% ?
 *        /      \                /      \
 *       是       否              是       否
 *       |        |               |        |
 *   核心專一   博學探索        潛力小眾   隨興體驗
 *    讀者       讀者            讀者       讀者
 */
public enum ReaderType {

    CORE_FOCUSED("核心專一讀者"),     // 多且專：總次數 >= 10 且 佔比 >= 70%
    EXPLORER("博學探索讀者"),         // 多且廣：總次數 >= 10 且 佔比 < 70%
    NICHE_POTENTIAL("潛力小眾讀者"),  // 少且專：總次數 < 10 且 佔比 >= 70%
    CASUAL("隨興體驗讀者");           // 少且廣：總次數 < 10 且 佔比 < 70%

    private final String label;

    ReaderType(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
