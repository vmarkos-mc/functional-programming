-- in-class/types_001.hs

import Data.Typeable(typeOf)

main :: IO ()
main = do
    print (typeOf 'a')
    print (typeOf "String")
    print (typeOf True)