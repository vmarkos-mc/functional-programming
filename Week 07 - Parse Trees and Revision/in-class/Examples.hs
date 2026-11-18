module Examples where

-- The trick here is to also expect the argument `x` as an argument
-- and let partial evaluation do the high level work.
comp :: (b -> c) -> (a -> b) -> a -> c
comp f g x = f $ g x


fold :: b -> (a -> b -> b) -> [a] -> b
fold acc _ []       = acc
fold acc f (x:xs)   = fold (f x acc) f xs