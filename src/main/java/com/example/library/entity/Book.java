package com.example.library.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 書籍實體，對應 SQLite 中的 books 資料表。
 *
 * genre 限制為五種類型：小說、科普、商業、歷史、漫畫
 * （此處不用 Enum 是因為要保留中文字串直接存入 SQLite TEXT 欄位，
 *  方便決策樹計算與前端顯示；驗證邏輯在 Service 層處理）
 */
@Entity
@Table(name = "books")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "書名不可為空")
    @Column(name = "title", nullable = false)
    private String title;

    @NotBlank(message = "類型不可為空")
    @Column(name = "genre", nullable = false)
    private String genre; // 小說 / 科普 / 商業 / 歷史 / 漫畫

    @Column(name = "author")
    private String author; // 可為空
}
