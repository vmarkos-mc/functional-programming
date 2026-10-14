import System.Win32 (COORD(xPos))
-- Countdown.hs

-- Declare useful data types.
-- `Operator` captures any of the four mathematical operators we will be using.
data Operator = Plus | Minus | Times | Div
    deriving Show

-- A syntactically valid mathematical expression is either a single integer,
-- captured by the `Value` constructor either an "inner" node of the expression
-- tree, captured by `Node`.
data Expression = Value Int
                | Node Expression Operator Expression
    deriving Show

-- Utilities
-- Checks whether an operator can be applied on two arguments
valid :: Operator -> Int -> Int -> Bool
valid Minus x y = x - y > 0
valid Div x y   = mod x y == 0
valid _ _ _     = True -- We do not match Plus / Times explicitly.

-- Applies an operator on two arguments
apply :: Operator -> Int -> Int -> Int
apply Plus x y  = x + y
apply Minus x y = x - y
apply Times x y = x * y
apply Div x y   = x `div` y

-- Splits a list into non-empty splittings in all possible ways (returned as a list of tuples)
-- E.g., nesplit [1, 2, 3] == [([1], [2, 3]), ([1, 2], [3])]
nesplit :: [a] -> [([a], [a])]
nesplit []      = []
nesplit [x]     = []
nesplit [x, y]  = [([x], [y])]
nesplit (x:xs)  = ([x], xs) : map (\ (y,z) -> (x:y, z)) (nesplit xs)

-- Subbags computes all possible permutations of all sublists of a given list
subbags :: [a] -> [[a]]
subbags ls = [p | subls <- sublist ls, p <- permutations subls]

-- Computes all permutations of a list
permutations :: [a] -> [[a]]
permutations []         = [[]]
permutations ls@(x:xs)  = map (x:) (permutations xs) ++ concat [map (r:) (permutations (l ++ rs)) | (l, r:rs) <- nesplit ls]

-- Computes all subsets of a list
sublist :: [a] -> [[a]]
sublist []      = [[]]
sublist (x:xs)  = ys ++ map (x:) ys
    where ys = sublist xs

-- Generates all valid expressions
exprs :: [Int] -> [Expression]
exprs []    = []
exprs [x]   = [Value x]
-- TODO: Combine all numbers with all operators using combine.
-- HINT: Use subbags to get all possible permutations of all sublists

-- Computes all valid combinations given certain inputs
combine :: Expression -> Expression -> [Expression]
combine (Value n) (Value m)
    | valid Minus n m && valid Div n m  = Node (Value n) Minus (Value m) : Node (Value n) Div (Value m) : alwaysValid
    | valid Minus n m                   = Node (Value n) Minus (Value m) : alwaysValid
    | valid Div n m                     = Node (Value n) Div (Value m) : alwaysValid
    | otherwise                         = alwaysValid
    where
        alwaysValid = [Node (Value n) Plus (Value m), Node (Value n) Times (Value m)]