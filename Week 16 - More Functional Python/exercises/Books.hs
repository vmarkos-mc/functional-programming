import System.IO
import Control.Monad
import Trace.Hpc.Util (readFileUtf8) -- This is useful for our case

main = do
    csvContents <- readFileUtf8 "books.csv"
    print ""    

splitOn :: String -> String -> [String]
splitOn delimiter string = splitOn' delimiter string []
    where
        splitOn' :: String -> String -> [String] -> [String]
        splitOn' _ "" splits = splits
        splitOn' delimiter string@(c:cs) splits = -- Homework