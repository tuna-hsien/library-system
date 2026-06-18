package com.example.library.controller;

import com.example.library.dto.BorrowRequest;
import com.example.library.entity.BorrowRecord;
import com.example.library.service.BorrowService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/borrow")
@RequiredArgsConstructor
public class BorrowController {

    private final BorrowService borrowService;

    /**
     * POST /api/borrow - 建立一筆借閱紀錄
     * Request Body 範例：{ "bookId": 1, "borrowerName": "王小明" }
     */
    @PostMapping
    public ResponseEntity<BorrowRecord> createBorrowRecord(@Valid @RequestBody BorrowRequest request) {
        BorrowRecord record = borrowService.createBorrowRecord(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(record);
    }
}
