-- Examples of custom types

type Point = (Float, Float)
type Color = (Int, Int, Int)
-- LogEntry (Severity, Description, Priority)
type LogEntry = (Int, [Char], Int)

translateX :: Point -> Float -> Point
translateX (x, y) dx = (x + dx, y)

reverseColor :: Color -> Color
reverseColor (r, g, b)  = (255 - r, 255 - g, 255 - b)

-- There are also ADTs (algebraic data types)

-- A Binary Tree (BT) is a tree where each node has at most two child nodes (or empty)
data BinaryTree a = Leaf | Node (BinaryTree a) (BinaryTree a)