
{- Rec Struct | Center Operator -} -- {{{

data List a = Empty | Cons a (List a)
  deriving (Show, Read, Eq, Ord)

mylist0 = 1:(2:(3:[]))
mylist1 = 1 `Cons` (2 `Cons` (3 `Cons` Empty))

-- Operate priority of R vector
infixr 5 :=:
data List0 a = Empty0 | a :=: (List0 a)
  deriving (Show, Read, Eq, Ord)

mylist2 = 1 :=: (2 :=: (3 :=: Empty0))
mylist3 = 1 :=: 2 :=: 3 :=: Empty0

infixr 5 +++
(+++) :: List0 a -> List0 a -> List0 a
Empty0   +++ ys = ys
(x:=:xs) +++ ys = x :=: xs +++ ys
-- GH's ans
-- (x:=:xs) +++ ys = x :=: (xs +++ ys)

lPrint = do
  putStrLn $ show mylist0
  putStrLn $ show mylist1
  putStrLn $ show mylist2
  putStrLn $ show mylist3

-- }}}

{- Tree Struct -} -- {{{

data Tree a = EmptyTree | Node a (Tree a) (Tree a)
  deriving (Show)

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singletonTree
  where singletonTree = Node x EmptyTree EmptyTree

treeInsert x (Node a left right)
  | x == a  = Node x left right
  | x <  a  = Node a (treeInsert x left) right
  | x >  a  = Node a left (treeInsert x right)

-- This is realy complete ?
examTree = foldr treeInsert EmptyTree [1,2,5,3,4,7,6,9,8]

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem _ EmptyTree = False
treeElem e (Node a left right) =
  if e == a then True else
    if e < a then treeElem e left
      else treeElem e right
-- }}}
