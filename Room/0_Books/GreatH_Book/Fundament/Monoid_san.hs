import Data.Monoid
import qualified Data.Foldable as F

{- Monoid Rules -}  --{{{

monoids0 =
  let -- These is a Monoid
      a = (4*1) == 4  -- unchanged value
      b = (1*4) == 4  --  * unchanging value
      c = ([1,2,3]++[]) == [1,2,3]
                        -- The two pattern of under is equals.
      d = 3 * (4 * 5)   -- This pattern have
        == (3 * 4) * 5  --   "associativity".
  in  show [a,b,c,d]
    ++ " is Monoids !"

--}}}

{- Monoid -} --{{{

--- Definition of Monoid class
-- class Monoid m where
--  mempty  :: m
--  mappend :: m -> m -> m
--  mconcat :: [m] -> m
--  mconcat = foldr mappend mempty

-- instance Monoid String where
--  mempty  = []
--  mappend = (++)
monoids1 =
  let a = ("hoge" `mappend` "foo") `mappend` "fuga"
      b = "hoge"  `mappend` ("foo" `mappend` "fuga")
  in  putStrLn $ a `mappend` "\n"
                   `mappend` b
                   `mappend` mempty

monoids2 =
  putStrLn $ show $ mconcat [[1..5], [6..8], [9,10]]

--}}}

{- Next Step -} --{{{

--- Definition of Monoid Ordering
-- instance Monoid Ordering where
--  mempty = EQ
--  LT `mappend` _ = LT
--  EQ `mappend` y = y
--  GT `mappend` _ = GT
comparence0 =
  [ LT `mappend` EQ,
    LT `mappend` GT,
    EQ `mappend` EQ,
    EQ `mappend` LT,
    GT `mappend` EQ,
    GT `mappend` LT,
    EQ `compare` EQ,
    LT     `mappend` mempty,
    mempty `mappend` GT ]


-- normally type
lencmp0 :: String -> String -> Ordering
lencmp0 x y =
  -- priority [a > b]
  let a = length x `compare` length y
      b = x `compare` y
  in  if a == EQ then b else a

lencmp1 :: String -> String -> Ordering
lencmp1 x y =
  (length x `compare` length y)  -- LT `compare` _ = LT
  `mappend`                      -- GT `compare` _ = GT
  (x `compare` y)                -- EQ `compare` o = o

--}}}

{- Counter Not Monoid value -} --{{{

--- Definition of First
-- instance Monoid (First a) where
--  mempty = First Nothing
--  First (Just x) `mappend` _ = First (Just x)
--  First Nothing  `mappend` x = x

-- Char is not monoid
wrapMaybe =
  let a = First (Just 'a') `mappend` First (Just 'b')
      b = First Nothing    `mappend` First (Just 'b')
      c = First (Just 'a') `mappend` First Nothing
  in  putStrLn $ show $ map getFirst [a,b,c]

--}}}

{- Fold Up Monoid -} --{{{

-- :t foldr
-- :t F.foldr

mFold0 =
  let a =   foldr (*) 2 [1,2,3]
      b = F.foldr (*) 2 [1,2,3]
  in  print $ a == b

mFold1 = F.foldl (+) 2 (Just 8)


----------

data Tree x = Empty | Node x (Tree x) (Tree x)
  deriving (Show)

instance F.Foldable Tree where
  -- foldMap is supporting fold functions.
  foldMap f Empty = mempty
  foldMap f (Node x l r) = F.foldMap f l `mappend`
                           f x           `mappend`
                           F.foldMap f r

tree =
  Node 10
    (Node 5
      (Node 3 Empty Empty)
      (Node 7 Empty Empty))
    (Node 15
      (Node 13 Empty Empty)
      (Node 17 Empty Empty))


-- ohhhhhhhhh!!!!!
foldup = F.foldr1 (+) tree

--}}}
