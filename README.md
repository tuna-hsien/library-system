# 圖書借閱者分類與推薦系統

Java Spring Boot + SQLite + Gemini API

## 1. 環境需求

- JDK 17+
- Maven 3.8+
- Gemini API Key（至 https://aistudio.google.com/app/apikey 取得）

## 2. 設定 Gemini API Key

建議透過環境變數注入，避免金鑰寫入版控：

```bash
export GEMINI_API_KEY=你的金鑰
```

或直接修改 `src/main/resources/application.properties` 中的：

```properties
gemini.api.key=你的金鑰
```

## 3. 啟動專案

```bash
mvn clean install
mvn spring-boot:run
```

啟動後會在專案根目錄自動產生 `library.db`（SQLite 檔案），Hibernate 會依 Entity 自動建立 `books`、`borrow_records` 兩張表（`spring.jpa.hibernate.ddl-auto=update`）。

## 4. 匯入測試資料（可選）

```bash
sqlite3 library.db < seed_data.sql
```

`seed_data.sql` 內建了 4 位測試用借閱者，分別對應決策樹的四種分類結果：

| 借閱者 | 總借閱次數 | 佔比 | 預期分類 |
|---|---|---|---|
| 王小明 | 12 | 75% (小說) | 核心專一讀者 |
| 李小華 | 11 | ~18% | 博學探索讀者 |
| 陳小美 | 4 | 100% (漫畫) | 潛力小眾讀者 |
| 張小強 | 3 | ~33% | 隨興體驗讀者 |

## 5. API 測試範例

```bash
# 取得所有書籍
curl http://localhost:8080/api/books

# 新增書籍
curl -X POST http://localhost:8080/api/books \
  -H "Content-Type: application/json" \
  -d '{"title":"測試書籍","genre":"小說","author":"測試作者"}'

# 修改書籍
curl -X PUT http://localhost:8080/api/books/1 \
  -H "Content-Type: application/json" \
  -d '{"title":"修改後書名","genre":"科普","author":"修改後作者"}'

# 刪除書籍
curl -X DELETE http://localhost:8080/api/books/1

# 建立借閱紀錄
curl -X POST http://localhost:8080/api/borrow \
  -H "Content-Type: application/json" \
  -d '{"bookId":1,"borrowerName":"王小明"}'

# 查詢讀者分類（決策樹結果）
curl http://localhost:8080/api/borrowers/王小明/type

# 取得個人化推薦書單（決策樹 + Gemini API）
curl http://localhost:8080/api/borrowers/王小明/recommendations
```

## 6. 專案結構

```
src/main/java/com/example/library/
├── LibrarySystemApplication.java   # 主程式進入點
├── config/
│   └── WebClientConfig.java        # WebClient Bean，供呼叫 Gemini API 使用
├── controller/
│   ├── BookController.java         # 書籍 CRUD 端點
│   ├── BorrowController.java       # 建立借閱紀錄端點
│   └── BorrowerController.java     # 讀者分類 / 推薦端點
├── dto/                            # 各端點 Request/Response 資料結構
├── entity/
│   ├── Book.java                   # books 資料表
│   └── BorrowRecord.java           # borrow_records 資料表（FK -> Book）
├── exception/                      # 自訂例外與全域例外處理器
├── repository/
│   ├── BookRepository.java
│   └── BorrowRecordRepository.java # 核心聚合查詢：依借閱者統計各類型借閱次數
└── service/
    ├── ReaderType.java                  # 四種讀者分類標籤 enum
    ├── ReaderClassificationService.java # ★ 核心決策樹分類邏輯
    ├── BookService.java
    ├── BorrowService.java
    ├── GeminiApiService.java            # 組裝 Prompt、呼叫 Gemini、解析 JSON
    └── RecommendationService.java       # 整合決策樹結果 + Gemini 推薦
```

## 7. 決策樹邏輯說明

核心程式碼位於 `ReaderClassificationService.applyDecisionTree()`：

```
總借閱次數 >= 10 ?
├─ 是 → 單一類型佔比 >= 70% ?
│        ├─ 是 → 核心專一讀者
│        └─ 否 → 博學探索讀者
└─ 否 → 單一類型佔比 >= 70% ?
         ├─ 是 → 潛力小眾讀者
         └─ 否 → 隨興體驗讀者
```

特徵計算透過 `BorrowRecordRepository.countByGenreForBorrower()` 的 JPQL 聚合查詢完成（`GROUP BY genre ORDER BY COUNT(*) DESC`），由資料庫端直接算出各類型借閱次數，效能優於撈全部資料到應用層再計算。

## 8. 注意事項

- SQLite 對並發寫入較敏感，已在 `application.properties` 中將連線池上限設為 1，避免 `database is locked` 錯誤。正式環境若需高並發寫入，建議改用 PostgreSQL/MySQL。
- `gemini.api.model` 預設使用 `gemini-2.0-flash`，可依需求改為其他可用模型版本。
- Gemini 回傳的 JSON 已在 Prompt 中嚴格限制格式，並在 `GeminiApiService` 額外做了 Markdown code fence 的防呆清理，但仍建議在正式環境加上重試機制（例如格式解析失敗時重新呼叫一次）。
