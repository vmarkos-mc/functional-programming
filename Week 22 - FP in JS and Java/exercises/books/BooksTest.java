package books;

import java.util.Hashtable;
import java.util.Enumeration;

public class BooksTest {
    public static void main(String[] args) {
        String BOOKS_CSV = "books/books.csv";
        Dataset books = new Dataset(BOOKS_CSV);
        Hashtable<String, Float> ratings = books.getAverageRatingPerAuthor();
        Enumeration<String> authors = ratings.keys();
        String author;
        while(authors.hasMoreElements()) {
            author = authors.nextElement();
            System.out.println(author + ": " + ratings.get(author));
        }
    }
}