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