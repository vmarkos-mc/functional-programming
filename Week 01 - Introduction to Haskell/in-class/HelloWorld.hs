-- HellowWorld.hs
{-
The above was a single line comment, while
this 
is
a 
multiline
one
.
-}

-- The first line below is the function signature, i.e.:
-- * what type of argument it gets as input and,
-- * what type it returns.
nextInt :: Int -> Int   -- Takes an Int(eger) and returns an Int(eger)
nextInt n = n + 1       -- Get n and return n + 1.

-- Observe that we do not use commas between arguments.
myAdd :: Int -> Int -> Int
myAdd m n = m + n

-- A list of all natural numbers up to 20.
naturals20 :: [Int]       -- [a] means list of type a.
naturals20 = [0..20]

-- A list of all natural numbers
naturals :: [Int]
naturals = [0..] -- This is an infinite list!

doubleInt :: Int -> Int
doubleInt n = 2*n

-- We can use the { description | from some set } syntax from set theory
-- For instance: Even = { 2n | n is a natural number }.
-- So, in what follows, "n <- naturals" means that n traverses all elements of naturals.
evenNaturals :: [Int]
evenNaturals = [ doubleInt n | n <- naturals ]


listSum :: [Int] -> Int
listSum [] = 0                  -- In case the list is empty, return 0.
listSum (n:ns) = n + listSum ns -- In case the least has at least one element
                                -- then add this element to the sum of the rest.
                                -- The (n:ns) syntax is the so-called (head:tail) syntax,
                                -- where head is the first *element* of the list,
                                -- while tail is the *list* of the rest elements (possibly empty)

-- Write a function that computes the factorial (n!) of a number n, i.e.:
-- 4! = 4 * 3 * 2 * 1

factorial :: Int -> Int
factorial 0 = 1                 -- The base case is that the factorial of 0 is 1
factorial n | n < 0 = 0         -- We use a guard here to take cases.
            | otherwise = n * factorial (n - 1)
                                -- So, we just step one down each time.
                                -- Also, "factorial n - 1" is not the same as "factorial (n-1)".


factorial' :: Int -> Int
factorial' 0 = 1                -- Base case as before
factorial' n | n < 0 = 0        -- This as well
             | otherwise = factorialHelper n 1  -- Here we call a helper function
    where                       -- This just narrows down the scope, so what follows is just visible within factorial'
        factorialHelper :: Int -> Int -> Int
        factorialHelper 1 acc = acc -- In the case case, we return the acc(umulated) value.
        factorialHelper n acc = factorialHelper (n - 1) (acc * n)
        {- 
        Here we are using the acc(umulator) to store the temporary product of all numbers
        from n down to 1, so that each call to factorialHelper is just another call to 
        factorialHelper.
        This practice is meaningful in languages that support Tail Call Optimization (TCO), such as
        **Haskell**
        -}


-- Enjoy yourselves by turning listSum into a TCO listSum'
listSum' :: [Int] -> Int
listSum' _ = ...