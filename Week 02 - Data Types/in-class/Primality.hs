isPrime :: Int -> Bool
isPrime n
    | n < 2     = False
    | otherwise = not $ any dividesN [2..m]
    where
        dividesN :: Int -> Bool
        dividesN k = n `mod` k == 0
        -- m = n - 1
        -- m = sqrt (fromIntegral n) -- Not working
        m = ceiling $ sqrt $ fromIntegral n


primes :: [Int]
primes = sieve [2..]
    where
        sieve :: [Int] -> [Int]
        sieve (n:ns) = n : sieve [ k | k <- ns, k `mod` n /= 0 ]