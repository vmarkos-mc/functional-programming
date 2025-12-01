-- in-class/activities.hs

noBore :: [Int] -> [Int]
-- Filter all integers that are boring*
-- boring positive integers are all that are > 10.
noBore ls = filter gt10 ls
    where gt10 x = x <= 10

-- Just using a lambda function
noBore' :: [Int] -> [Int]
noBore' ls = filter (\x -> x <= 10) ls
--                   ^
--                 lambda   

noBore'' :: [Int] -> [Int]
noBore'' ls = filter (<=10) ls
-- Essentially, we abstract out the input of the anonymous function above

noBore''' :: [Int] -> [Int]
noBore''' = filter (<=10)
-- We can drop ls, since we do not actually make any use of it.

evenLn :: [a] -> Bool
evenLn ls = even (length ls)

evenLn' :: [a] -> Bool
evenLn' ls = (even . length) ls
--                 ^
--            composition

-- Even more abstract
evenLn'' :: [a] -> Bool
evenLn'' = even . length

-- Our own function composition thing
comp :: (b -> c) -> (a -> b) -> (a -> c)
comp f g x = f (g x)
{--
In this case:
    * f is a function of type (b -> c), i.e., taking a single argument of type b and 
      returning a single value of type c.
    * f is a function of type (a -> b), i.e., taking a single argument of type a and 
      returning a single value of type b.
    * comp returns a function of type (a -> c), so x has to be of type a.

fromString: takes a string and parses it as an integer: String -> Int
div2      : takes an integer and divides it by 2      : Int -> Float

If we now define:

divStr2 = div2 . fromString

then its type should be: String -> Float

"37" ---------------> divStr2 ------------> 18.5

"37" ---> fromString ---> 37 ---> div2 ---> 18.5.
String                    Int               Float
--}

{--
filter --> Filters the contents of a list based on a boolean function.

Syntax: filter function list
where function (a -> Bool)
      list [a]

For instance:

```
filter foo [1, 2, 3, 4]

foo x = x > 3
```

This filters the list [1, 2, 3, 4] keeping only those values for which foo x == True,
so x > 3, so it only keeps [4].
--}

-- CURRYING

foo :: Int -> Int -> Int
foo x y = x + y

-- bar :: Int -> (Int -> Int)
-- bar x -> x + 

{--
So, under the hood, foo is defined as a function that gets a single integer, x, and 
returns a function that gets a single integer and computes it sum with x.
--}

-- foo' (x, y) -> x + y -- (x, y) is of type (2), i.e., a tuple of length 2.

-- FOLDING

fold :: b -> (a -> b -> b) -> [a] -> b
fold base _ []     = base
fold base f (x:xs) = f x (fold base f xs)