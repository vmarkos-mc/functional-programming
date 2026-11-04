module Golf where

skips :: [a] -> [[a]]
skips [] = []
skips ls = skips' ls n []
    where
        skips' _ 0 acc  = acc
        -- Comprehension alternative
        -- skips' ls n acc = skips' ls (n-1) ([ x | (i, x) <- ils, mod i n == 0 ] : acc)
        -- map / filter alternative
        -- skips' ls n acc = skips' ls (n-1) (sieved : acc)
        --     where
        --         sieved = map snd $ filter (\(i, _) -> mod i n == 0) ils
        -- ils = zip [1..n] ls -- Create pairs of the form (index, element)
        -- Composition approach
        skips' ls m acc = skips' ls (m-1) (sieved ls : acc)
            where
                -- What follows is a "pointless" definition, that is, we do not
                -- name the arguments but we just define things based on function
                -- composition, utilising partial functions.
                sieved :: [a] -> [a]
                sieved = (map snd) . (filter ((==0) . (`mod` m) . fst)) . (zip [1..n])
        n = length ls


-- localMaxima :: [Integer] -> [Integer]
-- localMaxima []          = []
-- localMaxima [x]         = []
-- localMaxima [x, y]      = []
-- localMaxima (x:y:z:xs)
--     | x < y && y > z    = y : localMaxima (y:z:xs)
--     | otherwise         = localMaxima (y:z:xs)


localMaxima :: [Integer] -> [Integer]
localMaxima ls@(x:y:xs) = 
    map (\(_, m, _) -> m) $ filter (\(x, y, z) -> x < y && y > z) $ zip3 ls (y:xs) xs
localMaxima _           = []


computeFrequencies :: [Integer] -> [Integer]
computeFrequencies ls = go ls (take 10 $ repeat 0)
    where
        go :: [Integer] -> [Integer] -> [Integer]
        go [] acc       = acc
        go (x:xs) acc   = 
            go xs (map (\(i, y) -> if i == x then y + 1 else y) $ zip [0..9] acc)