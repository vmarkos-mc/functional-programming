-- in-class/data_001.hs

main :: IO ()
main = do
    print cabbage
    print haskellEssentials

data HaskellStuff   = Functions
                    | Variables
                    | Cabbage
                    | Cabal
                    | Fun
    deriving Show

cabbage :: HaskellStuff
cabbage = Cabbage

haskellEssentials :: [HaskellStuff]
haskellEssentials = [Functions, Cabbage, Fun, Cabal, Fun]