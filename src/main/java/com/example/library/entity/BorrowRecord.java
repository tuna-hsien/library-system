package com.example.library.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

/**
 * 借閱紀錄實體，對應 SQLite 中的 borrow_records 資料表。
 * 透過 book_id 外鍵關聯至 books 資料表 (Many BorrowRecord -> One Book)。
 */
@Entity
@Table(name = "borrow_records")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BorrowRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 外鍵關聯：多筆借閱紀錄對應一本書
    @NotNull(message = "book_id 不可為空")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_id", nullable = false, foreignKey = @ForeignKey(name = "fk_borrow_book"))
    private Book book;

    @Column(name = "borrower_name", nullable = false)
    private String borrowerName;

    @Column(name = "borrow_date", nullable = false)
    private LocalDate borrowDate;
}
