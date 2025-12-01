module Lab01Data where

data ParseTree = Empty
               | Nmr Int
               | Add ParseTree ParseTree
               | Multiply ParseTree ParseTree
               | Modulus ParseTree ParseTree
    deriving (Show, Eq)
