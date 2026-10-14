-- Checks whether a credit card is valid or not

test :: [(Int, Bool)]
test = [(x, isValid x) | x <- [4012888888881881, 4012888888881882]]


{- The algorithm to follow is:
    1. Double every second digit, starting from the right.
    2. Add all digits.
    3. Take the remainder modulo 10.
    4. Check if it is 0 -> valid, else not valid
-}
isValid :: Int -> Bool
isValid n = (sumDigits $ doubleEverySecond $ toDigits n) `mod` 10 == 0
-- Using just prefix notation
-- isValid n = (==) (mod (sumDigits $ doubleEverySecond $ toDigits n) 10) 0
-- Using function composition
-- isValid n = ((sumDigits . doubleEverySecond . toDigits) n) `mod` 10 == 0
-- The parenthesised alternative is a bit hard to follow
-- isValid n = (sumDigits (doubleEverySecond (toDigits n))) `mod` 10 == 0


toDigits :: Int -> [Int]
toDigits n
    | n < 0     = toDigits (-n)         -- In case of a negative input, just ignore the sign
    | rest == 0 = [n]                   -- In this case, n has a single digit
    | otherwise = last:(toDigits rest)  -- The digits will end up in reverse order
    where
        (rest, last) = divMod n 10


doubleEverySecond :: [Int] -> [Int]
doubleEverySecond []        = []
doubleEverySecond [x]       = [x]
doubleEverySecond (x:y:xs)  = x:(2*y):(doubleEverySecond xs)


sumDigits :: [Int] -> Int
sumDigits ns = sum [sum $ toDigits n | n <- ns]