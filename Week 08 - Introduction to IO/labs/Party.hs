module Party where

import Employee
import qualified Control.Applicative as X

glCons :: Employee -> GuestList -> GuestList
glCons emp@(Emp _ f) (GL emps fun) = GL (emp:emps) (fun + f)
-- Named alternative
-- glCons (Emp { empName = _, empFun = f}) (emps, fun) = GL (emp:emps) (fun + f)

{-
In algebra, a Monoid is a set, X, with an operation, *, such that:

1. There exists an element e in X such that e*x = x*e = x for each x in X.
2. For each x, y, z in X: x * (y * z) = (x * y) * z, so we can just write x * y * z.

Besides + and * in numbers, function composition is also an operator with those properties on the 
set of all valid Haskell types.

Consider, lists, for example, i.e., let L(a) = { x is a list in Haskell of type a }. In this case:

* e == [] (of type a)
* * == ++, i.e., a * b ==  a ++ b, i.e., we concatenate two lists.

It is trivial to verify that:

* [] ++ x == x == x ++ [].
* x ++ (y ++ z) == (x ++ y) ++ z.

So, the set of all lists of type a, L(a), is a Monoid.
-}