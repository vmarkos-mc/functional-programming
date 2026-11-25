import Data.Char (isDigit)

type Token = String

data ParseTree = Number Int
               | Multiplication ParseTree ParseTree
               | Addition ParseTree ParseTree
               | Modulus ParseTree ParseTree
        deriving (Show, Eq)

parse :: String -> ParseTree
parse = parseTokens . tokenise


tokenise :: String -> [Token]
tokenise []         = []
tokenise str@(x:xs) 
                | x == ' '  = tokenise xs
                | isDigit x = takeWhile isDigit str : tokenise (dropWhile isDigit str)
                | otherwise = [x] : tokenise xs

parseTokens :: [Token] -> ParseTree
parseTokens [x]    = Number (read x)
parseTokens ls
            | "%" `elem` ls = consumeOp "%" Modulus
            | "+" `elem` ls = consumeOp "+" Addition
            | "*" `elem` ls = consumeOp "*" Multiplication
    where
        consumeOp :: Token -> (ParseTree -> ParseTree -> ParseTree) -> ParseTree
        consumeOp t cons = cons (parseTokens (takeWhile (/= t) ls)) (parseTokens (tail (dropWhile (/= t) ls)))
        -- Alternatively, we can use an operator table to store constructors and look it up whenever needed.
        -- opTable :: [(Token, ParseTree -> ParseTree -> ParseTree)]
        -- opTable = [ ("%", Modulus)
        --     , ("+", Addition)
        --     , ("*", Multiplication) ]

eval :: ParseTree -> Int
eval (Number n)                  = n
eval (Modulus left right)        = eval left `mod` eval right
eval (Addition left right)       = eval left + eval right
eval (Multiplication left right) = eval left * eval right

-- Think of an implementation of a foldParseTree to use below.
-- eval' :: ParseTree -> Int
-- eval' t = ...