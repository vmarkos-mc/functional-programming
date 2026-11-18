module Lab where

fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x:xs)
    | even x = (x - 2) * fun1 xs
    | otherwise = fun1 xs


fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n  | even n = n + fun2 (n `div` 2)
        | otherwise = fun2 (3 * n + 1)

-- Starting from 12:
-- 12 --> 6 --> 3 --> 10 --> 5 --> 16 --> 8 --> 4 --> 2 -- > 1 --> 0 (we stop)


fun1' :: [Integer] -> Integer
fun1' = product . (map (+(-2))) . (filter even)


fun2' :: Integer -> Integer
fun2' = sum
        . filter even
        . takeWhile (>1)
        . iterate (\x -> if even x then div x 2 else 3 * x + 1)


-- Exercise 2
data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
    deriving (Show, Eq)


foldTree :: [a] -> Tree a
foldTree = foldr addToTree Leaf
    where
        addToTree :: a -> Tree a -> Tree a
        addToTree x Leaf                    = Node 0 Leaf x Leaf
        addToTree x (Node h Leaf y Leaf)    = Node (h+1) (addToTree x Leaf) y Leaf
        addToTree x (Node h Leaf y right)   = Node h (addToTree x Leaf) y right
        addToTree x (Node h left y Leaf)    = Node h left y (addToTree x Leaf)
        addToTree x (Node h l@(Node lh _ _ _) y r@(Node rh _ _ _))
            | lh < rh   = Node h (addToTree x l) y r
            | lh > rh   = Node h l y (addToTree x r)
            | lh == rh  = Node (nlh+1) newLeft y r
            where
                newLeft@(Node nlh _ _ _) = addToTree x l

-- Homework: Make this run
beautify :: String -> String
beautify = go 0 ""
    where
        go :: Int -> String -> String -> String
        go _ acc ""     = reverse acc
        go k acc (c:cs)
            | c == '('  = go (k + 1) (tab ++ '\n':c:acc) cs
            | c == ')'  = go (k - 1) (c:tab ++ '\n':acc) cs
            | otherwise = go k (c:acc) cs
            where 
                tab = replicate (4*k) ' '


-- Exercise 3

xor :: [Bool] -> Bool
xor = foldr (/=) False

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x acc -> (f x):acc) []


-- Exercise 4

sieveSundaram :: Integer -> [Integer]
sieveSundaram n = map ((+1) . (*2))
                    $ filter (not . (`elem` s)) [1..n]
    where
        s = filter (<=n) [ i + j + 2 * i * j | j <- [1..(div n 3)], i <- [1..j]]