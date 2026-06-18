package com.example.library.service;

import com.example.library.dto.BorrowRequest;
import com.example.library.entity.Book;
import com.example.library.entity.BorrowRecord;
import com.example.library.exception.ResourceNotFoundException;
import com.example.library.repository.BookRepository;
import com.example.library.repository.BorrowRecordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class BorrowService {

    private final BorrowRecordRepository borrowRecordRepository;
    private final BookRepository bookRepository;

    /**
     * 建立一筆借閱紀錄。
     * 借閱日期固定採用伺服器當下日期，避免前端傳入不合理日期；
     * 若需支援前端自訂日期，可擴充 BorrowRequest 增加 borrowDate 欄位。
     */
    @Transactional
    public BorrowRecord createBorrowRecord(BorrowRequest request) {
        Book book = bookRepository.findById(request.getBookId())
                .orElseThrow(() -> new ResourceNotFoundException("找不到書籍，id=" + request.getBookId()));

        BorrowRecord record = BorrowRecord.builder()
                .book(book)
                .borrowerName(request.getBorrowerName())
                .borrowDate(LocalDate.now())
                .build();

        return borrowRecordRepository.save(record);
    }
}
