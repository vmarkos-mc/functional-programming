main :: IO()
main = print (take 100 primes)

primes :: [Integer]
primes = sieve [2..]
    where sieve (p:xs) = p : sieve [x | x <- xs, rem x p > 0]