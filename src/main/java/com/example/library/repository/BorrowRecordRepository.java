package com.example.library.repository;

import com.example.library.entity.BorrowRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BorrowRecordRepository extends JpaRepository<BorrowRecord, Long> {

    /**
     * 特徵計算核心查詢：依借閱者姓名，統計其「各書籍類型」的借閱次數。
     *
     * 對應 SQL 概念：
     *   SELECT b.genre, COUNT(*) 
     *   FROM borrow_records br JOIN books b ON br.book_id = b.id
     *   WHERE br.borrower_name = :name
     *   GROUP BY b.genre
     *   ORDER BY COUNT(*) DESC
     *
     * 回傳結果依次數由高到低排序，第一筆即為該讀者最常借閱的類型 (topGenre)，
     * 所有筆次加總即為「總借閱次數」(total_borrows)。
     */
    @Query("""
            SELECT br.book.genre AS genre, COUNT(br.id) AS cnt
            FROM BorrowRecord br
            WHERE br.borrowerName = :borrowerName
            GROUP BY br.book.genre
            ORDER BY cnt DESC
            """)
    List<GenreCountProjection> countByGenreForBorrower(@Param("borrowerName") String borrowerName);

    /**
     * 聚合查詢結果的投影介面 (Spring Data JPA Projection)，
     * 對應上方查詢中的 genre 與 cnt 兩個欄位。
     */
    interface GenreCountProjection {
        String getGenre();
        Long getCnt();
    }
}
