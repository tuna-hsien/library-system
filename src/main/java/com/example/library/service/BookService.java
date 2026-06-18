package com.example.library.service;

import com.example.library.entity.Book;
import com.example.library.exception.ResourceNotFoundException;
import com.example.library.repository.BookRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class BookService {

    /** 規格要求的五種合法書籍類型 */
    private static final Set<String> VALID_GENRES = Set.of("小說", "科普", "商業", "歷史", "漫畫");

    private final BookRepository bookRepository;

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Book getBookById(Long id) {
        return bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("找不到書籍，id=" + id));
    }

    @Transactional
    public Book createBook(Book book) {
        validateGenre(book.getGenre());
        return bookRepository.save(book);
    }

    @Transactional
    public Book updateBook(Long id, Book updated) {
        Book existing = getBookById(id);
        validateGenre(updated.getGenre());

        existing.setTitle(updated.getTitle());
        existing.setGenre(updated.getGenre());
        existing.setAuthor(updated.getAuthor());

        return bookRepository.save(existing);
    }

    @Transactional
    public void deleteBook(Long id) {
        if (!bookRepository.existsById(id)) {
            throw new ResourceNotFoundException("找不到書籍，id=" + id);
        }
        bookRepository.deleteById(id);
    }

    private void validateGenre(String genre) {
        if (genre == null || !VALID_GENRES.contains(genre)) {
            throw new IllegalArgumentException(
                    "genre 必須為以下五種之一：" + VALID_GENRES + "，目前傳入值：" + genre);
        }
    }
}
