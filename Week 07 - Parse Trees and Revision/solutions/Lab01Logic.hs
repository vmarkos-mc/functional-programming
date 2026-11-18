module Lab01Logic where

import Lab01Data

-- Partial solution

eval :: ParseTree -> Int
eval Empty          = -1
eval (Nmr x)        = x
eval (Add l r)      = eval l + eval r
eval (Multiply l r) = eval l * eval r
eval (Modulus l r)  = eval l `mod` eval r

parse :: String -> ParseTree
parse = parseTokens . tokenise

parseTokens :: [String] -> ParseTree
parseTokens []  = Empty
parseTokens [x] = Nmr (read x :: Int)
parseTokens ts | "%" `elem` ts = Modulus (parseTokens (takeWhile (/= "%") ts)) (parseTokens (tail (dropWhile (/= "%") ts)))
         | "+" `elem` ts = Add (parseTokens (takeWhile (/= "+") ts)) (parseTokens (tail (dropWhile (/= "+") ts)))
         | "*" `elem` ts = Multiply (parseTokens (takeWhile (/= "*") ts)) (parseTokens (tail (dropWhile (/= "*") ts)))
         | otherwise     = Empty

tokenise :: String -> [String]
tokenise ""       = []
tokenise (' ':xs) = tokenise xs
tokenise ('+':xs) = "+" : tokenise xs
tokenise ('*':xs) = "*" : tokenise xs
tokenise ('%':xs) = "%" : tokenise xs
tokenise s@(_:xs) = takeWhile isDigit s : tokenise (dropWhile isDigit xs)
    where
        isDigit x = x `elem` "0123456789"
