package books;

import java.util.Map;

public class BooksTest {
    public static void main(String[] args) {
        String BOOKS_CSV = "books/books.csv";
        Dataset books = new Dataset(BOOKS_CSV);
        Map<String, Double> ratings = books.getAverageRatingPerAuthor();
        // Using a lambda expression, there is no need for looping through a dictionary
        // using enumerations
        ratings.forEach((a, r) -> System.out.println(a + ": " + r));
    }
}