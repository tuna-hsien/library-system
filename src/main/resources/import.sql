-- =====================================================
-- 圖書借閱者分類與推薦系統 - 種子資料
-- 50 本書籍 (5 類 x 10 本) + 20 位借閱者 x 200 筆借閱紀錄
-- 借閱者分佈：
--   核心專一讀者 x5：總次數 16，單一類型佔比 >= 90%
--   博學探索讀者 x5：總次數 16，單一類型佔比 < 40%
--   潛力小眾讀者 x5：總次數 5， 單一類型佔比 >= 90%
--   隨興體驗讀者 x5：總次數 3， 單一類型佔比 < 40%
-- =====================================================

-- 清空既有資料（若有）
DELETE FROM borrow_records;
DELETE FROM books;

-- ---------------------------------------------------
-- 書籍資料 (books)：50 本，5 種類型各 10 本
-- ---------------------------------------------------
INSERT INTO books (id, title, genre, author) VALUES (1, '百年孤寂', '小說', '加布列·賈西亞·馬奎斯');
INSERT INTO books (id, title, genre, author) VALUES (2, '挪威的森林', '小說', '村上春樹');
INSERT INTO books (id, title, genre, author) VALUES (3, '1984', '小說', '喬治·歐威爾');
INSERT INTO books (id, title, genre, author) VALUES (4, '小王子', '小說', '安托萬·聖修伯里');
INSERT INTO books (id, title, genre, author) VALUES (5, '追風箏的人', '小說', '卡勒德·胡賽尼');
INSERT INTO books (id, title, genre, author) VALUES (6, '罪與罰', '小說', '杜斯妥也夫斯基');
INSERT INTO books (id, title, genre, author) VALUES (7, '傲慢與偏見', '小說', '珍·奧斯汀');
INSERT INTO books (id, title, genre, author) VALUES (8, '白鯨記', '小說', '赫爾曼·梅爾維爾');
INSERT INTO books (id, title, genre, author) VALUES (9, '百萬種人生', '小說', '未知');
INSERT INTO books (id, title, genre, author) VALUES (10, '解憂雜貨店', '小說', '東野圭吾');
INSERT INTO books (id, title, genre, author) VALUES (11, '時間簡史', '科普', '史蒂芬·霍金');
INSERT INTO books (id, title, genre, author) VALUES (12, '物種起源', '科普', '達爾文');
INSERT INTO books (id, title, genre, author) VALUES (13, '自私的基因', '科普', '理查·道金斯');
INSERT INTO books (id, title, genre, author) VALUES (14, '宇宙的結構', '科普', '布萊恩·葛林');
INSERT INTO books (id, title, genre, author) VALUES (15, '基因聖戰', '科普', '未知');
INSERT INTO books (id, title, genre, author) VALUES (16, '人類大歷史', '科普', '哈拉瑞');
INSERT INTO books (id, title, genre, author) VALUES (17, '元素的盛宴', '科普', '山姆·肯恩');
INSERT INTO books (id, title, genre, author) VALUES (18, '腦袋裡的怪東西', '科普', '未知');
INSERT INTO books (id, title, genre, author) VALUES (19, '量子力學概論', '科普', '未知');
INSERT INTO books (id, title, genre, author) VALUES (20, '細胞的秘密生活', '科普', '未知');
INSERT INTO books (id, title, genre, author) VALUES (21, '窮查理的普通常識', '商業', '查理·蒙格');
INSERT INTO books (id, title, genre, author) VALUES (22, '原子習慣', '商業', '詹姆斯·克利爾');
INSERT INTO books (id, title, genre, author) VALUES (23, '從0到1', '商業', '彼得·提爾');
INSERT INTO books (id, title, genre, author) VALUES (24, '精實創業', '商業', '艾瑞克·萊斯');
INSERT INTO books (id, title, genre, author) VALUES (25, '黑天鵝效應', '商業', '納西姆·塔雷伯');
INSERT INTO books (id, title, genre, author) VALUES (26, '藍海策略', '商業', '金偉燦');
INSERT INTO books (id, title, genre, author) VALUES (27, '好策略壞策略', '商業', '理查·魯梅特');
INSERT INTO books (id, title, genre, author) VALUES (28, '致富心態', '商業', '摩根·豪瑟');
INSERT INTO books (id, title, genre, author) VALUES (29, '引爆趨勢', '商業', '麥爾坎·葛拉威爾');
INSERT INTO books (id, title, genre, author) VALUES (30, '基業長青', '商業', '詹姆·柯林斯');
INSERT INTO books (id, title, genre, author) VALUES (31, '槍炮、病菌與鋼鐵', '歷史', '賈德·戴蒙');
INSERT INTO books (id, title, genre, author) VALUES (32, '史記', '歷史', '司馬遷');
INSERT INTO books (id, title, genre, author) VALUES (33, '世界史的誕生', '歷史', '岡田英弘');
INSERT INTO books (id, title, genre, author) VALUES (34, '羅馬帝國衰亡史', '歷史', '愛德華·吉朋');
INSERT INTO books (id, title, genre, author) VALUES (35, '明朝那些事兒', '歷史', '當年明月');
INSERT INTO books (id, title, genre, author) VALUES (36, '二十一世紀資本論', '歷史', '湯瑪斯·皮凱提');
INSERT INTO books (id, title, genre, author) VALUES (37, '文明的衝突', '歷史', '杭廷頓');
INSERT INTO books (id, title, genre, author) VALUES (38, '第三帝國興亡史', '歷史', '威廉·夏伊勒');
INSERT INTO books (id, title, genre, author) VALUES (39, '台灣通史', '歷史', '連橫');
INSERT INTO books (id, title, genre, author) VALUES (40, '絲路全史', '歷史', '彼得·梵科潘');
INSERT INTO books (id, title, genre, author) VALUES (41, '進擊的巨人', '漫畫', '諫山創');
INSERT INTO books (id, title, genre, author) VALUES (42, '鬼滅之刃', '漫畫', '吾峠呼世晴');
INSERT INTO books (id, title, genre, author) VALUES (43, '航海王', '漫畫', '尾田榮一郎');
INSERT INTO books (id, title, genre, author) VALUES (44, '火影忍者', '漫畫', '岸本齊史');
INSERT INTO books (id, title, genre, author) VALUES (45, '灌籃高手', '漫畫', '井上雄彥');
INSERT INTO books (id, title, genre, author) VALUES (46, '死亡筆記本', '漫畫', '大場鶇');
INSERT INTO books (id, title, genre, author) VALUES (47, '七龍珠', '漫畫', '鳥山明');
INSERT INTO books (id, title, genre, author) VALUES (48, '名偵探柯南', '漫畫', '青山剛昌');
INSERT INTO books (id, title, genre, author) VALUES (49, '排球少年', '漫畫', '古館春一');
INSERT INTO books (id, title, genre, author) VALUES (50, '間諜過家家', '漫畫', '遠藤達哉');

-- ---------------------------------------------------
-- 借閱紀錄 (borrow_records)：20 位借閱者，共 200 筆
-- ---------------------------------------------------

-- 陳家豪（核心專一讀者，共 16 筆，主類型約 小說，佔比 94%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (6, '陳家豪', '2025-04-08');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (7, '陳家豪', '2025-01-25');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (3, '陳家豪', '2025-04-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (5, '陳家豪', '2025-03-30');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (19, '陳家豪', '2025-03-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '陳家豪', '2025-01-12');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '陳家豪', '2025-04-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (7, '陳家豪', '2025-05-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (9, '陳家豪', '2025-02-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (3, '陳家豪', '2025-04-07');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (7, '陳家豪', '2025-01-21');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (8, '陳家豪', '2025-05-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '陳家豪', '2025-03-17');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '陳家豪', '2025-04-03');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (3, '陳家豪', '2025-05-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (2, '陳家豪', '2025-02-19');

-- 林雅婷（核心專一讀者，共 16 筆，主類型約 科普，佔比 94%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (14, '林雅婷', '2025-04-13');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (14, '林雅婷', '2025-03-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (17, '林雅婷', '2025-01-17');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (11, '林雅婷', '2025-02-24');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (18, '林雅婷', '2025-05-26');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (20, '林雅婷', '2025-03-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (10, '林雅婷', '2025-02-24');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (13, '林雅婷', '2025-05-08');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (11, '林雅婷', '2025-04-12');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (12, '林雅婷', '2025-04-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (13, '林雅婷', '2025-02-06');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (13, '林雅婷', '2025-03-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (13, '林雅婷', '2025-02-05');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (13, '林雅婷', '2025-03-05');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (17, '林雅婷', '2025-05-24');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (13, '林雅婷', '2025-05-18');

-- 黃志明（核心專一讀者，共 16 筆，主類型約 商業，佔比 94%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (21, '黃志明', '2025-03-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (26, '黃志明', '2025-05-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (22, '黃志明', '2025-02-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (28, '黃志明', '2025-05-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (24, '黃志明', '2025-01-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (29, '黃志明', '2025-03-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (25, '黃志明', '2025-05-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (30, '黃志明', '2025-02-20');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (23, '黃志明', '2025-02-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (24, '黃志明', '2025-04-06');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (26, '黃志明', '2025-02-11');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (27, '黃志明', '2025-05-19');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (23, '黃志明', '2025-05-16');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (21, '黃志明', '2025-01-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (8, '黃志明', '2025-03-24');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (21, '黃志明', '2025-05-06');

-- 張淑芬（核心專一讀者，共 16 筆，主類型約 歷史，佔比 94%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (31, '張淑芬', '2025-01-31');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (40, '張淑芬', '2025-03-05');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (40, '張淑芬', '2025-02-27');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (38, '張淑芬', '2025-01-17');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (39, '張淑芬', '2025-03-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (9, '張淑芬', '2025-01-06');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (38, '張淑芬', '2025-05-31');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (35, '張淑芬', '2025-05-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (31, '張淑芬', '2025-02-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (32, '張淑芬', '2025-05-31');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (39, '張淑芬', '2025-02-26');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (39, '張淑芬', '2025-01-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (35, '張淑芬', '2025-01-19');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (31, '張淑芬', '2025-01-16');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (34, '張淑芬', '2025-02-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (31, '張淑芬', '2025-01-18');

-- 李建宏（核心專一讀者，共 16 筆，主類型約 漫畫，佔比 94%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (43, '李建宏', '2025-05-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (45, '李建宏', '2025-04-25');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (47, '李建宏', '2025-02-05');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (45, '李建宏', '2025-04-19');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (46, '李建宏', '2025-02-16');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (41, '李建宏', '2025-03-13');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (43, '李建宏', '2025-04-29');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (42, '李建宏', '2025-03-05');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (42, '李建宏', '2025-01-20');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (49, '李建宏', '2025-04-24');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (48, '李建宏', '2025-05-21');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (50, '李建宏', '2025-01-26');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (49, '李建宏', '2025-01-13');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (7, '李建宏', '2025-05-19');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (50, '李建宏', '2025-01-04');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (41, '李建宏', '2025-01-24');

-- 王思涵（博學探索讀者，共 16 筆，主類型約 小說，佔比 25%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (35, '王思涵', '2025-02-17');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (7, '王思涵', '2025-01-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (11, '王思涵', '2025-01-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '王思涵', '2025-03-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (43, '王思涵', '2025-04-14');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (13, '王思涵', '2025-01-31');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (27, '王思涵', '2025-05-26');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (39, '王思涵', '2025-03-05');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (17, '王思涵', '2025-05-29');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (48, '王思涵', '2025-01-11');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (25, '王思涵', '2025-01-21');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (37, '王思涵', '2025-04-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (44, '王思涵', '2025-05-30');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (8, '王思涵', '2025-05-25');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '王思涵', '2025-05-14');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (28, '王思涵', '2025-03-22');

-- 吳俊傑（博學探索讀者，共 16 筆，主類型約 小說，佔比 25%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (40, '吳俊傑', '2025-01-27');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (32, '吳俊傑', '2025-02-04');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (40, '吳俊傑', '2025-03-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '吳俊傑', '2025-01-30');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (44, '吳俊傑', '2025-01-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (28, '吳俊傑', '2025-05-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (16, '吳俊傑', '2025-02-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (22, '吳俊傑', '2025-03-11');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (49, '吳俊傑', '2025-03-14');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (15, '吳俊傑', '2025-02-23');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (42, '吳俊傑', '2025-03-29');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (3, '吳俊傑', '2025-02-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (5, '吳俊傑', '2025-03-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (18, '吳俊傑', '2025-05-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (7, '吳俊傑', '2025-05-06');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (21, '吳俊傑', '2025-03-06');

-- 蔡佳穎（博學探索讀者，共 16 筆，主類型約 歷史，佔比 25%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (49, '蔡佳穎', '2025-01-27');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (16, '蔡佳穎', '2025-04-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (13, '蔡佳穎', '2025-05-24');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (43, '蔡佳穎', '2025-04-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (28, '蔡佳穎', '2025-02-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (32, '蔡佳穎', '2025-03-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (31, '蔡佳穎', '2025-02-11');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (5, '蔡佳穎', '2025-02-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (39, '蔡佳穎', '2025-04-16');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (23, '蔡佳穎', '2025-01-07');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '蔡佳穎', '2025-02-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (29, '蔡佳穎', '2025-03-27');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (37, '蔡佳穎', '2025-04-16');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (15, '蔡佳穎', '2025-03-05');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (42, '蔡佳穎', '2025-03-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '蔡佳穎', '2025-02-10');

-- 劉柏宏（博學探索讀者，共 16 筆，主類型約 商業，佔比 25%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (16, '劉柏宏', '2025-03-30');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (27, '劉柏宏', '2025-03-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (35, '劉柏宏', '2025-04-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (24, '劉柏宏', '2025-05-11');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (46, '劉柏宏', '2025-01-30');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (21, '劉柏宏', '2025-04-09');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (49, '劉柏宏', '2025-05-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (8, '劉柏宏', '2025-02-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (15, '劉柏宏', '2025-03-07');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '劉柏宏', '2025-01-12');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '劉柏宏', '2025-04-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (14, '劉柏宏', '2025-01-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (24, '劉柏宏', '2025-05-14');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (45, '劉柏宏', '2025-05-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (36, '劉柏宏', '2025-02-20');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (32, '劉柏宏', '2025-04-04');

-- 鄭雅文（博學探索讀者，共 16 筆，主類型約 漫畫，佔比 25%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (44, '鄭雅文', '2025-02-13');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (39, '鄭雅文', '2025-01-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (2, '鄭雅文', '2025-03-14');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (6, '鄭雅文', '2025-05-12');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (26, '鄭雅文', '2025-03-27');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (47, '鄭雅文', '2025-01-24');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (43, '鄭雅文', '2025-03-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (15, '鄭雅文', '2025-03-21');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (47, '鄭雅文', '2025-02-27');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (15, '鄭雅文', '2025-02-20');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (33, '鄭雅文', '2025-02-07');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (19, '鄭雅文', '2025-01-07');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (10, '鄭雅文', '2025-01-12');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (27, '鄭雅文', '2025-03-04');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (27, '鄭雅文', '2025-05-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (35, '鄭雅文', '2025-01-19');

-- 楊承恩（潛力小眾讀者，共 5 筆，主類型約 小說，佔比 100%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '楊承恩', '2025-01-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (6, '楊承恩', '2025-04-19');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (5, '楊承恩', '2025-02-26');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (9, '楊承恩', '2025-02-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (8, '楊承恩', '2025-05-13');

-- 許美玲（潛力小眾讀者，共 5 筆，主類型約 科普，佔比 100%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (15, '許美玲', '2025-05-21');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (12, '許美玲', '2025-04-25');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (16, '許美玲', '2025-02-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (20, '許美玲', '2025-05-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (12, '許美玲', '2025-04-26');

-- 謝宗翰（潛力小眾讀者，共 5 筆，主類型約 商業，佔比 100%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (28, '謝宗翰', '2025-03-15');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (23, '謝宗翰', '2025-03-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (26, '謝宗翰', '2025-03-11');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (27, '謝宗翰', '2025-03-27');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (23, '謝宗翰', '2025-03-23');

-- 曾巧雯（潛力小眾讀者，共 5 筆，主類型約 歷史，佔比 100%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (34, '曾巧雯', '2025-03-26');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (32, '曾巧雯', '2025-05-19');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (32, '曾巧雯', '2025-04-30');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (39, '曾巧雯', '2025-04-17');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (31, '曾巧雯', '2025-01-16');

-- 周冠宇（潛力小眾讀者，共 5 筆，主類型約 漫畫，佔比 100%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (50, '周冠宇', '2025-04-01');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (43, '周冠宇', '2025-03-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (45, '周冠宇', '2025-04-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (46, '周冠宇', '2025-04-18');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (47, '周冠宇', '2025-05-18');

-- 蔣怡君（隨興體驗讀者，共 3 筆，主類型約 (分散)，佔比 33%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (37, '蔣怡君', '2025-04-10');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (44, '蔣怡君', '2025-03-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (15, '蔣怡君', '2025-04-14');

-- 趙文彬（隨興體驗讀者，共 3 筆，主類型約 (分散)，佔比 33%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (1, '趙文彬', '2025-01-22');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (20, '趙文彬', '2025-04-20');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (39, '趙文彬', '2025-02-04');

-- 潘曉雯（隨興體驗讀者，共 3 筆，主類型約 (分散)，佔比 33%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (6, '潘曉雯', '2025-03-25');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (17, '潘曉雯', '2025-03-28');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (35, '潘曉雯', '2025-04-08');

-- 賴信宏（隨興體驗讀者，共 3 筆，主類型約 (分散)，佔比 33%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (38, '賴信宏', '2025-03-31');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (22, '賴信宏', '2025-02-27');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (11, '賴信宏', '2025-01-18');

-- 高于喬（隨興體驗讀者，共 3 筆，主類型約 (分散)，佔比 33%）
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (41, '高于喬', '2025-02-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (40, '高于喬', '2025-05-02');
INSERT INTO borrow_records (book_id, borrower_name, borrow_date) VALUES (4, '高于喬', '2025-01-30');