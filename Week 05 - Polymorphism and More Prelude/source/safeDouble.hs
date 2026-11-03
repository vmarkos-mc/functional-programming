main :: IO()
main = do
    print iList
    print (intListProd iList)

data IntList = Empty | Cons Int IntList
    deriving Show

iList :: IntList
iList = Cons 5 (Cons 4 (Cons 3 (Cons 2 Empty)))
-- The above is equivalent to 5:4:3:2:[]
-- You can read `Cons h t` as: "Construct a list by appending h to t",
-- where h is an integer and t is a list of integers.

intListProd :: IntList -> Int
intListProd Empty      = 1
intListProd (Cons x l) = x * intListProd l