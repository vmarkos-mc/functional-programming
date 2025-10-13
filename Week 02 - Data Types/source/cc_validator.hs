main :: IO()
main = print [(x, is_valid x) | x <- [4012888888881881, 4012888888881882]]
-- The above should print True and False, respectively

-- This is practically useless
toDigits :: Integer -> [Integer]
toDigits n = (reverse . toDigitsRev) n -- Function composition

-- This is the core of the solution
toDigitsRev :: Integer -> [Integer]
toDigitsRev n | n < 1 = []
              | n < 10 = [n]
              | otherwise = (rem n 10):(toDigitsRev (div n 10))

-- Let's define this one with pattern matching
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (x:y:xs) = x:(2 * y):(doubleEveryOther xs)

-- How about some pattern matching + guards + where?
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) | x < 10 = x + sumDigits xs
                 | otherwise = d + r + (sumDigits xs)
                    where d = div x 10
                          r = rem x 10

-- Just check
is_valid :: Integer -> Bool
is_valid n = rem ((sumDigits . doubleEveryOther . toDigitsRev) n) 10 == 0