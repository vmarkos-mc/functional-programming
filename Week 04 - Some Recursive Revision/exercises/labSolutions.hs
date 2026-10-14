-- in-class/labSolutions.hs

-- Exercise 1: Compute the maximum of a list in a simple- and tail-recursive
-- way (max', and max'', respectively)

-- `Ord` is a Haskell type class, i.e., a family of types that share the common
-- attribute of being order-able (ordinals), i.e., they can be ordered in some way.
-- Examples might include Integers, Floats, Doubles, Strings, etc.

-- Bad idea
-- Running: `badMax' [1..25]` takes unexpectedly more time that it would appear.
-- However, running `badMax [25,24..1]` does not. Why?
--
-- Actually, in the first case, where elements are sorted in increasing order, Haskell
-- roughly computes things as follows:
-- badMax' [1..25]
--      x > badMax' [2..25]             --> This fully evaluates badMax' [2..25]
--      Evantually, the above condition is evaluted to `False`.
--      otherwise = badMax' [2..25]     --> This, again, fully evaluates badMax' [2..25]
--
-- On the contrary, for [25,24..1]:
-- badMax' [25,24..1]
--      x > badMax' [24,23..1]             --> This fully evaluates badMax' [24,23..1]
--      Evantually, the above condition is evaluted to `True`.
--      So, we never proceed to evaluate the 'otherwise' part.
--

badMax' :: Ord a => [a] -> a
badMax' [x] = x -- Base case, singleton list.
badMax' (x:xs)
    | x > badMax' xs = x
    | otherwise = badMax' xs

max' :: Ord a => [a] -> a
max' [x] = x -- Base case, singleton list.
max' (x:xs)
    | x > m = x
    | otherwise = m
    where m = max' xs

max'' :: Ord a => [a] -> a
max'' (x:xs) = auxMax'' xs x
    where
        auxMax'' [] currentMax = currentMax
        auxMax'' (x:xs) currentMax
            | x > currentMax = auxMax'' xs x
            | otherwise = auxMax'' xs currentMax

-- Exercise 2: List sum

-- Simple recursion
sum' :: [Float] -> Float
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- Tail recursion
sum'' ::[Float] -> Float
sum'' [] = 0
sum'' (x:xs) = auxSum'' xs x
    where
        auxSum'' [] currentSum = currentSum
        auxSum'' (x:xs) currentSum = auxSum'' xs x + currentSum

-- Exercise 3: Fibonacci sequence
-- f_n = f_{n-1} + f_{n-2}
-- f_0 = 0, f_1 = 1

-- Bad idea since, among others, we make two recursive calls
-- each time, so 2 ^ n in total (most of which are wasted).
fib :: Integer -> Integer
fib 0 = 0 -- Base case for n == 0
fib 1 = 1 -- Base case for n == 1
fib n = fib (n - 1) + fib (n - 2)

fib' :: Integer -> Integer
-- Implement this at home!
fib' 0 = 0
fib' 1 = 1

-- Exercise 5: splitAt'

-- Assume that n is always within bounds
splitAt' :: [a] -> Integer -> ([a], [a])
splitAt' [] _ = ([], []) -- Base case
splitAt' ls n = auxSplit ls n [] 0 -- Utilise a tail recursive auxilliary function
    where
        -- `ls` is the initial list, missing the first `currentN` elements,
        -- which are included in `left`
        auxSplit ls@(x:xs) n left currentN
            | currentN == n = (left, ls)
            | otherwise = auxSplit xs n (left ++ [x]) (currentN + 1)
-- Reminder: For lists, the ls@(x:xs) syntax means:
--  * ls keeps the entire list;
--  * x keeps the list head (first element);
--  * xs keeps the list tail (all but the first element as a list).

-- Exercise 6: Merge of sorted lists (Not tail recursive, though)
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys         = ys
merge xs []         = xs
merge a@(x:xs) b@(y:ys)
    | x < y     = x : merge xs b
    | otherwise = y : merge a ys

-- Exercise 7: Merge sort
mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort ls = merge (mergeSort l) (mergeSort r)
    where
        (l, r) = splitAt' ls (length' ls `div` 2)

-- Custom length function
length' :: [a] -> Integer
length' [] = 0
length' (_:xs) = 1 + length' xs