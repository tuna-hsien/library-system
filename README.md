# 📚 圖書借閱者分類與推薦系統

### 🚀 期末挑戰任務：極速全端系統整合實戰 (Hackathon)

本專案為計算機概論期末實戰挑戰任務（題目 B），在限時 **3 小時** 內獨自化身全端工程師，利用 AI 工具進行 Vibe Coding，打造出兼具：

* Java Spring Boot 後端
* SQLite 資料庫
* 響應式網頁前端
* 機器學習決策樹
* Google Gemini API 整合

的完整圖書館自動化系統。

---

## 🔗 專案連結

* **作品部署連結 (Live Demo)**
  `library-system-production-ad58.up.railway.app`

* **GitHub Repository**
  `https://github.com/tuna-hsien/library-system.git`

* **AI 對話紀錄 (AI Chat History)**
  Gemini`https://share.gemini.google/u5V7bPOvpdly`
  Claude`https://claude.ai/share/5ee47988-6cda-493c-b3cf-9a77511a88b9`

---

# 1️⃣ 全端系統架構與資料流向

## 系統架構圖

```text
 [ 前端網頁：HTML5 / JS / Tailwind CSS ]
      │                               ▲
      │ (1) POST /api/borrow          │
      │ (2) GET  /borrowers/{name}/type
      ▼                               │
 [ 後端服務：Java Spring Boot ] ──────┴─────► Google Gemini API
      │                                       (產生個人化推薦)
      │
      │ 執行聚合查詢
      │ 決策樹分類
      ▼
 [ SQLite Database ]
```

---

## 🔄 核心資料流動

### 1. 借閱流程

1. 使用者於前端選擇書籍並輸入姓名
2. 前端發送：

```http
POST /api/borrow
```

3. Spring Boot 將借閱紀錄寫入 SQLite
4. 前端重新取得資料列表
5. 畫面同步更新

---

### 2. 分析與分類流程

使用者輸入姓名後點擊「查詢分析」。

後端透過 JPQL 聚合查詢：

```sql
GROUP BY
COUNT(*)
```

計算：

* 總借閱次數
* 最常借閱類型
* 類型佔比

---

### 3. 決策樹分類

取得統計結果後：

```text
借閱次數
類型集中度
```

作為特徵輸入決策樹進行分類。

---

### 4. AI 推薦流程

後端組裝 Prompt：

```text
讀者分類
+
最常借閱類型
```

傳送至 Gemini API。

Gemini 依照分類結果動態產生：

* 3～5 本推薦書單
* 推薦理由
* JSON 格式回應

最後回傳至前端顯示。

---

# 2️⃣ 核心技術棧

| 類別            | 技術                                  |
| ------------- | ----------------------------------- |
| 後端框架          | Java 17                             |
| Web Framework | Spring Boot 3.2.5                   |
| ORM           | Spring Data JPA                     |
| 資料庫           | SQLite                              |
| JDBC Driver   | SQLite JDBC 3.46.0.0                |
| ORM 方言        | Hibernate Community Dialects        |
| AI 模型         | Gemini 2.0 Flash / Gemini 1.5 Flash |
| 前端            | HTML5 + JavaScript                  |
| UI            | Tailwind CSS                        |
| API           | Fetch API                           |
| 部署平台          | Railway                             |

---

# 3️⃣ 機器學習：決策樹分類模型

為了展現「模型與商務邏輯整合」，本系統實作多層 Decision Tree，而非單純關鍵字判斷。

---

## 🌳 決策樹結構

```text
               [開始分析]
                     │
         借閱次數 >= 10 ?
              /           \
            是             否
            │             │
      類型佔比>=70%?   類型佔比>=70%?
         /      \        /       \
       是       否      是       否
       │        │       │        │
核心專一讀者 博學探索讀者 潛力小眾讀者 隨興體驗讀者
```

---

## 📊 分類規則

| 借閱次數 | 類型集中度 | 分類結果   |
| ---- | ----- | ------ |
| 高    | 高     | 核心專一讀者 |
| 高    | 低     | 博學探索讀者 |
| 低    | 高     | 潛力小眾讀者 |
| 低    | 低     | 隨興體驗讀者 |

---

# 4️⃣ 驗證用種子資料

系統內建 Seed Data，確保每個分支皆能被觸發。

| 讀者  | 特徵        | 分類     |
| --- | --------- | ------ |
| 王小明 | 12次、小說75% | 核心專一讀者 |
| 李小華 | 11次、類型分散  | 博學探索讀者 |
| 陳小美 | 4次、漫畫100% | 潛力小眾讀者 |
| 張小強 | 3次、類型分散   | 隨興體驗讀者 |

---

# 5️⃣ RESTful API 規格

| Method | Endpoint                                | 功能      |
| ------ | --------------------------------------- | ------- |
| GET    | `/api/books`                            | 取得所有藏書  |
| POST   | `/api/books`                            | 新增書籍    |
| POST   | `/api/borrow`                           | 建立借閱紀錄  |
| GET    | `/api/borrowers/{name}/type`            | 取得讀者分類  |
| GET    | `/api/borrowers/{name}/recommendations` | AI 書籍推薦 |

---

## API 範例

### 建立借閱紀錄

```http
POST /api/borrow
Content-Type: application/json
```

```json
{
  "borrowerName": "王小明",
  "bookId": 1
}
```

---

### 查詢讀者分類

```http
GET /api/borrowers/王小明/type
```

Response：

```json
{
  "readerType": "核心專一讀者",
  "totalBorrows": 12,
  "favoriteCategory": "小說"
}
```

---

# 6️⃣ 環境設定

## 設定 Gemini API 金鑰

### Linux / macOS

```bash
export GEMINI_API_KEY=你的Gemini金鑰
```

### Windows PowerShell

```powershell
$env:GEMINI_API_KEY="你的Gemini金鑰"
```

---

# 7️⃣ 專案啟動

## 編譯專案

```bash
./mvnw clean package -DskipTests
```

---

## 啟動服務

```bash
./mvnw spring-boot:run
```

Windows：

```bash
.\mvnw spring-boot:run
```

---

啟動後：

```text
http://localhost:8080
```

即可開啟系統。

SQLite 會自動建立：

```text
library.db
```

並完成資料表初始化。

---

# 8️⃣ Vibe Coding 開發心得

本次 3 小時 Hackathon 深度實踐：

> 「讓 AI 做苦工，人來做決策」

---

## Prompt Engineering

透過結構化 Prompt：

* 快速產出 Spring Boot 專案骨架
* 建立 JPA Entity
* 配置 SQLite Dialect
* 完成 REST API

大幅縮短開發時間。

---

## AI 協助除錯

部署期間曾遭遇：

### Port 8080 was already in use

原因：

* 本機已有服務佔用 Port

解法：

* 關閉衝突程序
* 改用 Railway 動態 Port

---

### Cannot unwrap to requested type

原因：

* SQLite Driver 版本衝突

解法：

* 調整 pom.xml
* 移除重複 JDBC Driver

---

### CORS / API 連線失敗

原因：

* 前端綁定 localhost

解法：

* 改用相對路徑

```javascript
/api/books
```

避免部署後跨域問題。

---

# 🎯 專案亮點

✅ Spring Boot + SQLite 全端整合

✅ RESTful API 設計

✅ Decision Tree 分類模型

✅ Gemini API 個人化推薦

✅ Railway 雲端部署

✅ 響應式前端介面

✅ AI 協作開發（Vibe Coding）

---

# 📄 License

This project is for educational purposes and final project demonstration.
