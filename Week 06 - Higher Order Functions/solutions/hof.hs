------------------------------------------------
-- Exercise 1
------------------------------------------------

testFun1 :: Bool
testFun1 = all (== True) [fun1 x == fun1' x | x <- [[1..n] | n <- [1..100]]]

testFun2 :: Bool
testFun2 = all (== True) [fun2 x == fun2' x | x <- [1..100]]

fun1 :: [Integer] -> Integer
fun1 []     = 1
fun1 (x:xs) 
    | even x    = (x - 2) * fun1 xs
    | otherwise = fun1 xs

fun1' :: [Integer] -> Integer
fun1' = product . map (\x -> x - 2) . filter even

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n | even n     = n + fun2 (n `div` 2)
       | otherwise  = fun2 (3 * n + 1)

fun2' :: Integer -> Integer
fun2' = sum . filter even . takeWhile (>1) . iterate step
    where step n | even n    = n `div` 2
                 | otherwise = 3 * n + 1

------------------------------------------------
-- Exercise 2
------------------------------------------------

data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
    deriving (Show, Eq)

foldTree :: [a] -> Tree a
foldTree = foldr insert Leaf
    where insert x Leaf = Node 0 Leaf x Leaf
          insert x (Node _ Leaf c Leaf) = Node 1 (insert x Leaf) c Leaf
          insert x (Node d Leaf c r) = Node d (insert x Leaf) c r
          insert x (Node d l c Leaf) = Node d l c (insert x Leaf)
          insert x (Node d l@(Node ld _ _ _) c r@(Node rd _ _ _))
            | ld < rd  = Node d (insert x l) c r
            | ld > rd  = Node d l c (insert x r)
            | otherwise = Node (1 + ld) (insert x l) c r

-- The above miscomputes subtree height by overestimating it.
-- Fix the above to properly display height for each subtree.
-- Hint: You can use a recursive function to compute the height of a (sub)tree 
-- and use that to compute the height in the above, instead of `d`, `ld`, and `rd`.

------------------------------------------------
-- Exercise 3
------------------------------------------------

xor :: [Bool] -> Bool
xor = odd . foldr countTrue 0
    where countTrue True y = 1 + y
          countTrue False y = y

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x y -> f x : y) []

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f base xs = foldr (\x y -> f y x) base (reverse  xs)

------------------------------------------------
-- Exercise 4
------------------------------------------------

sundaSieve :: Int -> [Int]
sundaSieve n = [2 * k + 1 | k <- filter (`notElem` m) [1..n]]
    where m = [i + j + 2 * i * j | j <- [1..n], i <- [1..j], i + j + 2 * i * j <= n]