main :: IO()
main = print [(x, isPrimeG x) | x <- [-5..35]]

-- Function that checks whether a single integer is prime.
isPrime :: Int -> Bool
isPrime 1 = False
isPrime n = length [x | x <- [1..m], rem n x == 0] == 1
    where m = floor (sqrt (fromIntegral n))

-- Function that checks primality using guard (complete)
isPrimeG :: Int -> Bool
isPrimeG n | n < 2 = False
           | otherwise = length [x | x <- [1..m], rem n x == 0] == 1
             where m = floor (sqrt (fromIntegral n))

-- Function that implements Eratosthenes's sieve algorithm.
sieve :: Int -> [Int]
sieve 1 = [1]