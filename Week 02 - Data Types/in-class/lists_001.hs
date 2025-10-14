-- in-class/lists_001.hs

main :: IO ()
main = do
    print a
    print (head a)
    print (tail a)
    print (init a)
    print (last a)

a = [3, 1, 2, 5, 8]