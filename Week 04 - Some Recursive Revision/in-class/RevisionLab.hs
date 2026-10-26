module RevisionLab where

-- newtype Empty = Empty Empty -- Just an empty type

-- `Ord a` means that `a` is some type that can be ordered, e.g., Int
max' :: Ord a => [a] -> a
max' []     = undefined
max' [x]    = x
max' (x:xs)
    | x > y     = x
    | otherwise = y
    where
        y = max' xs
-- max' [x, y] = if x > y then x else y
-- max' (x:xs) = max' [ x, max' xs ]
-- Alternative, using `if... then... else...`
-- max' (x:xs) = if x > y then x else y
--     where y = max' xs

max'' :: Ord a => [a] -> a
max'' []        = undefined
max'' (x:xs)    = max''' xs x
    where
        max''' :: Ord a => [a] -> a -> a
        max''' [] acc       = acc
        max''' (x:xs) acc   = max''' xs (if x > acc then x else acc)


sum' :: Num a => [a] -> a
sum' []     = 0
sum' (x:xs) = x + sum' xs


sum'' :: Num a => [a] -> a
sum'' ls = sum''' ls 0
    where
        sum''' :: Num a => [a] -> a -> a
        sum''' [] acc       = acc
        sum''' (x:xs) acc   = sum''' xs (x + acc)

-- Bad solution.
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

-- Faster solution (TCO)
fib' :: Int -> Int
fib' 0 = 0
fib' 1 = 1
fib' n = fib'' n 1 0
    where
        fib'' :: Int -> Int -> Int -> Int
        fib'' 2 curr prev = curr + prev
        fib'' n curr prev = fib'' (n-1) (curr + prev) curr
    
{- As a loop:
curr = 1
prev = 0
for i in range(n):
    prev = curr
    curr = curr + prev
-}

splitAt' :: Int -> [a] -> ([a], [a])
splitAt' _ [] = ([], []) -- Or, undefined
splitAt' n ls = splitAt'' n ls []
    where
        splitAt'' :: Int -> [a] -> [a] -> ([a], [a])
        splitAt'' 0 ls left     = (reverse left, ls) -- For our use case, reverse is not actually needed
        splitAt'' n (x:xs) left = splitAt'' (n-1) xs (x:left)


{-
Splitting at n as a loop:

left = []
for i in [0..n]:
    left.append(ls[i])
return (left, ls[n+1:])
-}


merge :: Ord a => [a] -> [a] -> [a]
merge [] b      = b
merge a []      = a
merge a@(x:xs) b@(y:ys)
    | x < y     = x : (merge xs b)
    | otherwise = y : (merge ys a)


splitToSingletons :: [a] -> [[a]]
splitToSingletons ls = [ [x] | x <- ls ]


mergeAll :: Ord a => [[a]] -> [[a]]
mergeAll []     = []
mergeAll [x]    = [x]
mergeAll (x:y:xs)   = (merge x y) : (mergeAll xs)


mergeSort :: Ord a => [a] -> [a]
mergeSort ls = mergeFull singles
    where
        singles = splitToSingletons ls
        mergeFull :: Ord a => [[a]] -> [a]
        mergeFull [x] = x
        mergeFull ls  = mergeFull $ mergeAll ls