package books;
// Package is a rough equivalent of a C# namespace

import java.io.BufferedReader;
import java.io.FileReader;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Hashtable;
import java.time.LocalDate;
import java.util.Enumeration;


public class Dataset {
    private ArrayList<Book> books;

    public Dataset() {};

    public Dataset(String csvPath) {
        this.books = new ArrayList<Book>();
        boolean isFirstLine = true;
        try (BufferedReader br = new BufferedReader(new FileReader(csvPath))) {
            String line;
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("M/d/yyyy");
            while ((line = br.readLine()) != null) {
                if (isFirstLine) {
                    isFirstLine = false;
                    continue;
                }
                String[] values = line.split(",");
                Book book = new Book(
                    values[1],
                    values[2],
                    Float.parseFloat(values[3]),
                    values[4],
                    values[5],
                    values[6],
                    Integer.parseInt(values[7]),
                    Integer.parseInt(values[8]),
                    Integer.parseInt(values[9]),
                    LocalDate.parse(values[10], dateFormatter),
                    values[10]
                );
                books.add(book);
            }
        } catch (Exception e) {
            // Dummy way to handle exception
            System.out.println(e);
        }
    }

    public Hashtable<String, Float> getAverageRatingPerAuthor() {
        Hashtable<String, Float> totalRating = new Hashtable<String, Float>();
        Hashtable<String, Integer> totalReviewsCount = new Hashtable<String, Integer>();
        String authors;
        float bookRating;
        int ratingsCount;
        for (Book book : books) {
            authors = book.getAuthors();
            ratingsCount = book.getRatingsCount();
            bookRating = book.getAverageRating() * ratingsCount;
            if (totalRating.containsKey(authors)) {
                totalRating.put(authors, totalRating.get(authors) + bookRating);
                totalReviewsCount.put(
                    authors,
                    totalReviewsCount.get(authors) + ratingsCount
                );
            } else {
                totalRating.put(authors, bookRating);
                totalReviewsCount.put(authors, ratingsCount);
            }
        }
        Hashtable<String, Float> authorsRating = new Hashtable<String, Float>();
        Enumeration<String> keys = totalRating.keys();
        while (keys.hasMoreElements()) {
            authors = (String) keys.nextElement();
            authorsRating.put(authors, totalRating.get(authors) / totalReviewsCount.get(authors));
        }
        return authorsRating;
    }
}
