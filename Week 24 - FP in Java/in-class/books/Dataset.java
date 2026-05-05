package books;
// Package is a rough equivalent of a C# namespace

import java.io.BufferedReader;
import java.io.FileReader;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Map;
import javafx.util.Pair;
import java.time.LocalDate;
import java.util.stream.Collector;
import java.util.stream.Collectors;


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
                    values[11]
                );
                books.add(book);
            }
        } catch (Exception e) {
            // Dummy way to handle exception
            System.out.println(e);
        }
    }

//(b) -> new Pair(b.getRatingsCount(), b.getAverageRating() * b.getRatingsCount())

    public Map<String, Double> getAverageRatingPerAuthor() {
        // ALternative: Impement custom collector computing pairs of values
        // public static Collector<Book, ?, Pair<Integer, Double>> ratingsCollector() {
        //     return Collector.of(
        //         () -> new Pair<Integer, Double>(0, 0.0),
        //         (b) -> new Pair(b.getRatingsCount(), b.getAverageRating() * b.getRatingsCount()),
        //         (b, c) -> new Pair(b.getRatingsCount(), b.getAverageRating() * b.getRatingsCount()),
        //         (a) -> a
        //     );
        // };
        // Map<String, Pair<Integer, Double>> totalRatings
        //     = books.stream()
        //            .collect(
        //                 Collectors.groupingBy(Book::getAuthors,
        //                     new Collector<Book, Pair<Integer, Double>, Pair<Integer, Double>>(
        //                     )
        //                 )
        //            );
        Map<String, Integer> totalReviewsCount
            = books.stream()
                   .collect(
                        Collectors.groupingBy(Book::getAuthors,
                            Collectors.summingInt(Book::getRatingsCount)
                        )
                    );
        Map<String, Double> totalRating
            = books.stream()
                   .collect(
                        Collectors.groupingBy(Book::getAuthors,
                            Collectors.summingDouble((b) -> b.getAverageRating() * b.getRatingsCount())
                        )
                   );
        totalRating.replaceAll((a, r) -> r / totalReviewsCount.get(a));
        /*
        Beware! While this expression accepts a (key, value) pair, it returns just
        just the value, assigning it to the same key.
        In other words, `.replaceAll()` implements an in-place replacement
         */
        return totalRating;
    }
}


/*
Dynamic way to compute a weighted average as it comes.

Assume at some point that we know the particular value of the weighted average,
let x.

Then, we have a new observation, with value v and corresponding weight w. Then, the 
new updated value should be:

x -> update enumerator with `+ v * w`
x -> update denominator with `+ w`

Evidently, we lack sufficient information, e.g., the denominator's value. In case we know that,
let d, we can compute the new denominator value as follows:

x <- (x * d + v * w) / (d + w).
d <- d + w

 */