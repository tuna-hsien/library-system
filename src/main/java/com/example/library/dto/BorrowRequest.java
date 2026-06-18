package com.example.library.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * POST /api/borrow 的請求 Body
 * 範例：{ "bookId": 1, "borrowerName": "王小明" }
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BorrowRequest {

    @NotNull(message = "bookId 不可為空")
    private Long bookId;

    @NotBlank(message = "borrowerName 不可為空")
    private String borrowerName;
}
