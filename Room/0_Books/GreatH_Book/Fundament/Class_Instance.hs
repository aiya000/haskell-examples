{- Either -} -- {{{

hogee :: a -> b -> (Either a x, Either y b)
hogee a b = (Left a, Right b)

fooab :: Bool -> a -> b -> Either a b
fooab f a b = if f then Left a else Right b
hoget = fooab True "Yes!!" 10

-- }}}

{- Class Deriving manually -} --{{{

-- Base type class
data Color = Red | Blue | Green --deriving(Eq)

-- 
{- Defined Eq Class -} -- {{{
-- class Eq a where
--   x == y = not (x /= y)
--   x /= y = nor (x == y)
-- }}}
instance Eq Color where
  Red   == Red   = True
  Blue  == Blue  = True
  Green == Green = True
  _     == _     = False
  -- Red /= Blue = False ...

instance Show Color where
  show Red   = "| Red   |"
  show Blue  = "| Blue  |"
  show Green = "| Green |"
  
examPrint = do
  print $ Red  == Red
  print $ Blue == Green
  putStrLn $ show Red
  putStrLn $ show Blue
  putStrLn $ show Green
--}}}

{- Defining Class -} -- {{{

class YesNo a where
  yesno :: a -> Bool

-- deriving
instance YesNo Int where
  yesno 0 = False
  yesno _ = True
instance YesNo [a] where
  yesno [] = False
  yesno _  = True

yesnoIf :: (YesNo f) => f -> String
yesnoIf f = if yesno f then "YES!!" else "NO!!!"

yesInt = yesnoIf (1::Int)
yesStr = yesnoIf "hoge"
noStr  = yesnoIf ""

-- }}}

{- Functor -} -- {{{

-- class Functor f where
  -- fmap :: (a -> b) -> f a -> f b
-- :t map => map :: (a -> b) -> [a] -> [b]
-- instance Functor [] where
  -- fmap = map
fmaps = ("map implementing of Functor->fmap", fmap (*2) [1..10], map (*2) [1..10])

-- instance Functor Maybe where
  -- fmap f (Just x) = Just (f x)
  -- fmap f Nothing  = Nothing
maybeFmap  = ("Maybe is Functor instance", fmap (*2) $ Just 10, fmap (*2) Nothing)


---
data Tree e = EmptyTree | Node e (Tree e) (Tree e)
  deriving (Show, Eq, Ord)

makeTree :: (Ord a) => [a] -> Tree a
makeTree [] = EmptyTree
makeTree xs = foldr insertTree EmptyTree xs
  where singleton x = Node x EmptyTree EmptyTree
        insertTree x EmptyTree = singleton x
        insertTree x (Node a left right)
          | x == a  = Node x left right
          | x <  a  = Node a (insertTree x left) right
          | x >  a  = Node a left (insertTree x right)

-- implementation
instance Functor Tree where
  fmap f EmptyTree = EmptyTree
  fmap f (Node x left right) = Node (f x) (fmap f left) (fmap f right)


-- Implementation of Multi argment Value
data Hoge a b = Hoge a b deriving Show
instance Functor (Hoge a) where
  fmap f (Hoge a b) = Hoge a (f b)
  
hogehoo x y = Hoge x y
-- }}}
