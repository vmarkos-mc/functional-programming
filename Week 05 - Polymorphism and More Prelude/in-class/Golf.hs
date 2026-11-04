module Golf where

skips :: [a] -> [[a]]
skips [] = []
skips ls = skips' ls n []
    where
        skips' _ 0 acc  = acc
        skips' ls n acc = skips' ls (n-1) ([ x | (i, x) <- ils, mod i n == 0 ] : acc)
        ils = zip [1..n] ls -- Create pairs of the form (index, element)
        n = length ls