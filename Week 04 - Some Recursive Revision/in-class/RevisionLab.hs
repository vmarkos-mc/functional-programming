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