package com.example.library.controller;

import com.example.library.dto.ReaderProfile;
import com.example.library.dto.ReaderTypeResponse;
import com.example.library.dto.RecommendationResponse;
import com.example.library.service.ReaderClassificationService;
import com.example.library.service.RecommendationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/borrowers")
@RequiredArgsConstructor
public class BorrowerController {

    private final ReaderClassificationService classificationService;
    private final RecommendationService recommendationService;

    /**
     * GET /api/borrowers/{name}/type
     * 回傳該借閱者的總借閱次數、最大佔比與決策樹分類類型
     */
    @GetMapping("/{name}/type")
    public ResponseEntity<ReaderTypeResponse> getReaderType(@PathVariable String name) {
        ReaderProfile profile = classificationService.classify(name);

        ReaderTypeResponse response = ReaderTypeResponse.builder()
                .borrowerName(profile.getBorrowerName())
                .totalBorrows(profile.getTotalBorrows())
                .maxGenreRatio(profile.getMaxGenreRatio())
                .topGenre(profile.getTopGenre())
                .readerType(profile.getReaderType())
                .build();

        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/borrowers/{name}/recommendations
     * 結合決策樹分類結果與 Gemini API，回傳個人化推薦書單
     */
    @GetMapping("/{name}/recommendations")
    public ResponseEntity<RecommendationResponse> getRecommendations(@PathVariable String name) {
        return ResponseEntity.ok(recommendationService.recommendFor(name));
    }
}
