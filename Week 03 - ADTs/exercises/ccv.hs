-- in-class/ccv.hs

main :: IO ()
main = print [(x, isValid x) | x <- [4012888888881881, 4012888888881882]]

-- isValid checks a credit card number's validity
isValid :: Int -> Bool
isValid n = mod (addAllDigits (doubleEverySecond (splitToDigits n))) 10 == 0

-- Doubles every second element of the list, (maybe counting from right?)
doubleEverySecond :: [Int] -> [Int]
doubleEverySecond [] = []
doubleEverySecond [n] = [n]
doubleEverySecond (x:y:rest) = x:2 * y:doubleEverySecond rest

-- Adds all digits of every element of the list
addAllDigits :: [Int] -> Int
addAllDigits [] = 0
addAllDigits (x:xs) = digitSum x + addAllDigits xs

-- Computes the sum of all digits of a non-negative integer
digitSum :: Int -> Int
digitSum n
    | m == 0 = n
    | otherwise = mod n 10 + digitSum m
    where m = div n 10

-- Splits an integer to a list of its digits
splitToDigits :: Int -> [Int]
splitToDigits n
    | m == 0 = [n]
    | otherwise = mod n 10:splitToDigits m
    where m = div n 10

-- Trying to run:
-- ```
-- splitToDigits (-1)
-- ```
-- yields a seemingly infinite list of 9's (?)
-- This is because `mod` is always restricted to a non-negative output.
-- So, -1 `mod` 10 == -1 in practice, but for `mod` this is shifted 10 on the right
-- so it yields 9. In a similar fashion, (-1) `div` 10 == -1, so we are stuck to an 
-- infinite recursion since we always repeat the same values.
