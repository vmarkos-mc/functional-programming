-- in-class/ccv.hs

main :: IO ()
main = print [(x, isValid x) | x <- [4012888888881881, 4012888888881881]]

-- isValid checks a credit card number's validity
isValid :: Int -> Bool
isValid n = mod (addAllDigits (doubleEverySecond (splitToDigits n))) 10 == 0

-- Doubles every second element of the list, counting from right
doubleEverySecond :: [Int] -> [Int]
doubleEverySecond [] = []

-- Adds all digits of every element of the list
addAllDigits :: [Int] -> Int
addAllDigits [] = 0

-- Splits an integer to a list of its digits
splitToDigits :: Int -> [Int]
splitToDigits n
    | m == 0 = [n]
    | otherwise = mod n 10:splitToDigits m
    where m = div n 10