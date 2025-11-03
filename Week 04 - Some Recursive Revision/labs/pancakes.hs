-- pancakes.hs
--
-- Generating random permutations using merge sort.

-- Merge sort implementation (just for reference, you will not 
-- need this as is.

-- `merge` merges two "ordered" lists
merge :: Ord a => [a] -> [a] -> [a]
merge [] x = x
merge x [] = x
merge lx@(x:xs) ly@(y:ys)
	| x < y 	= x : merge xs ly
	| otherwise = y : merge lx ys

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort l) (mergeSort r)
	where (l, r) = splitAt (div (length xs) 2) xs

-- Merge shuffling essentially boild down to merging lists in a 
-- uniformly random way, i.e., all n! factorial permutations might occur
-- with the same probability.
