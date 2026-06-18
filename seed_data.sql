-- =====================================================
-- 測試用種子資料（可選）
-- 用法：啟動應用程式後，自行透過 sqlite3 CLI 或 DB Browser 匯入，
--       或改寫成 data.sql 放在 resources 下讓 Spring Boot 自動執行
-- =====================================================

-- 書籍資料
INSERT INTO books (title, genre, author) VALUES ('百年孤寂', '小說', '加布列·賈西亞·馬奎斯');
INSERT INTO books (title, genre, author) VALUES ('挪威的森林', '小說', '村上春樹');
INSERT INTO books (title, genre, author) VALUES ('1984', '小說', '喬治·歐威爾');
INSERT INTO books (title, genre, author) VALUES ('人類大歷史', '歷史', '哈拉瑞');
INSERT INTO books (title, genre, author) VALUES ('槍炮、病菌與鋼鐵', '歷史', '賈德·戴蒙');
INSERT INTO books (title, genre, author) VALUES ('窮查理的普通常識', '商業', '查理·蒙格');
INSERT INTO books (title, genre, author) VALUES ('原子習慣', '商業', '詹姆斯·克利爾');
INSERT INTO books (title, genre, author) VALUES ('時間簡史', '科普', '史蒂芬·霍金');
INSERT INTO books (title, genre, author) VALUES ('物種起源', '科普', '達爾文');
INSERT INTO books (title, genre, author) VALUES ('進擊的巨人', '漫畫', '諫山創');

-- 借閱紀錄：王小明 -> 12 次借閱，全部都是小說 (測試「核心專一讀者」)
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '王小明', '2025-01-05');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (2, '王小明', '2025-01-12');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (3, '王小明', '2025-01-19');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '王小明', '2025-02-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (2, '王小明', '2025-02-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (3, '王小明', '2025-02-16');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '王小明', '2025-03-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (2, '王小明', '2025-03-08');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (3, '王小明', '2025-03-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '王小明', '2025-04-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (2, '王小明', '2025-04-08');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '王小明', '2025-04-15');

-- 借閱紀錄：李小華 -> 11 次借閱，類型分散 (測試「博學探索讀者」)
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '李小華', '2025-01-03');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '李小華', '2025-01-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (6, '李小華', '2025-01-17');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (8, '李小華', '2025-01-24');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (10, '李小華', '2025-02-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (2, '李小華', '2025-02-08');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (5, '李小華', '2025-02-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (7, '李小華', '2025-02-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (9, '李小華', '2025-03-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (3, '李小華', '2025-03-08');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '李小華', '2025-03-15');

-- 借閱紀錄：陳小美 -> 4 次借閱，全部都是漫畫 (測試「潛力小眾讀者」)
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (10, '陳小美', '2025-05-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (10, '陳小美', '2025-05-08');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (10, '陳小美', '2025-05-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (10, '陳小美', '2025-05-22');

-- 借閱紀錄：張小強 -> 3 次借閱，類型分散 (測試「隨興體驗讀者」)
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '張小強', '2025-06-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (6, '張小強', '2025-06-08');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (8, '張小強', '2025-06-15');
