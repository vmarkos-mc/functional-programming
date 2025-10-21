-- in-class/primality.hs

main :: IO ()
main = print [(x, isPrime x) | x <- [1..30]]

-- Checks whether a given integer is prime or not.
isPrime :: Int -> Bool
isPrime n
    | n < 2 = False
    | otherwise = not (any divides [(n, d) | d <- divisors])
    where divisors = [2..(n-1)]

-- Gets a pair of integers (n, m), checking whether m divides n.
divides :: (Int, Int) -> Bool
divides (n, m) = mod n m == 0

-- Right from hoogle:
-- `all :: (a -> Bool) -> [a] -> Bool`
-- This is all's type signature, reading from right to left:
--  * all returns a boolean (Bool);
--  * To do so, it expects two arguments:
--      - A list of elements of type a ([a]);
--      - A function getting something of type a as an input and
--          returning something of type Bool ( (a -> Bool) )