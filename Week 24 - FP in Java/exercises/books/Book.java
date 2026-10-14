package books;

import java.time.LocalDate;

public class Book {
    private static int count = 0; // Used to autoincrement book id
    private int bookId;
    private String title;
    private String authors; // This could be a separate class
    private float averageRating;
    private String isbn;
    private String isbn13;
    private String languageCode;
    private int numPages;
    private int ratingsCount;
    private int textReviewsCount;
    private LocalDate publicationDate;
    private String publisher;

    public Book(
        String title,
        String authors,
        float averageRating,
        String isbn,
        String isbn13,
        String languageCode,
        int numPages,
        int ratingsCount,
        int textReviewsCount,
        LocalDate publicationDate,
        String publisher
    ) {
        this.bookId = count++; // `this` is redundant here, as there is no ambiguity
        this.title = title;
        this.authors = authors;
        this.averageRating = averageRating;
        this.isbn = isbn;
        this.isbn13 = isbn13;
        this.languageCode = languageCode;
        this.numPages = numPages;
        this.ratingsCount = ratingsCount;
        this.textReviewsCount = textReviewsCount;
        this.publicationDate = publicationDate;
        this.publisher = publisher;
    }

    public float getAverageRating() {
        return averageRating;
    }

    public int getRatingsCount() {
        return ratingsCount;
    }

    public String getAuthors() {
        return authors;
    }
}
