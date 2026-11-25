import Data.Char (isDigit)

data ParseTree = Number Int
               | Multiplication ParseTree ParseTree
               | Addition ParseTree ParseTree
               | Modulus ParseTree ParseTree
        deriving (Show, Eq)

parse :: String -> ParseTree
parse = parseTokens . tokenise


tokenise :: String -> [String]
tokenise []         = []
tokenise str@(x:xs) 
                | x == ' '  = tokenise xs
                | isDigit x = takeWhile isDigit str : tokenise (dropWhile isDigit str)
                | otherwise = [x] : tokenise xs

parseTokens :: [String] -> ParseTree
parseTokens [x]    = Number (read x)
parseTokens ls
            | "%" `elem` ls = Modulus (parseTokens (takeWhile (/= "%") ls)) (parseTokens (tail (dropWhile (/= "%") ls)))
            | "+" `elem` ls = Addition (parseTokens (takeWhile (/= "+") ls)) (parseTokens (tail (dropWhile (/= "+") ls)))
            | "*" `elem` ls = Multiplication (parseTokens (takeWhile (/= "*") ls)) (parseTokens (tail (dropWhile (/= "*") ls)))

eval :: ParseTree -> Int
eval (Number n)                  = n
eval (Modulus left right)        = eval left `mod` eval right
eval (Addition left right)       = eval left + eval right
eval (Multiplication left right) = eval left * eval right