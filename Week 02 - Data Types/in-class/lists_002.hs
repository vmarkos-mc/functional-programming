import qualified Control.Applicative as Haskell
import Distribution.Simple.Utils (xargs)
-- in-class/list_002.hs

-- Recursive solutions to tasks of In-class Exercise #002 (W01)

-- Empty lists have 0 length

-- Non empty lists have length of 1 + the length of their tail.
len [] = 0
len xs = 1 + len (tail xs)

-- Some remarks
-- 1. Pattern matching in Haskell works top-to-bottom, so
--      the first pattern is checked for matching, then the second etc
-- 2. So, in the above, the second pattern should fail for an empty list,
--      however it won't, since the empty list pattern is always matched first.

-- Alternative with more advanced pattern matching.
len' [] = 0
len' (h:t) = 1 + len t
-- The syntax (h:t) splits the list into head and tail

-- Computing a list maximum
max' [x] = x
max' (h:t) = max2 h (max' t)

max2 x y
    | x < y = y
    | otherwise = x

-- The '|' operator denotes in this case a "guard", i.e., a way to distinguish between different
-- cases in Haskell.
-- The 'otherwise' keyword is, more or less, a "True" statement.

-- Alternative implementation of max':
max'' [x] = x
max'' ls@(h:t) = maxHelper ls h
-- `ls@(h:t)` pattern-match matches:
--  1. a list named `ls`;
--  2. with head `h`'
--  3. and tails `t`.

-- We define a helper function, that keeps track of the current maximum element.
maxHelper [x] m | x < m = m | otherwise = x -- Inline guard
maxHelper (h:t) m
    | h < m = maxHelper t m
    | otherwise = maxHelper t h