import Control.Applicative

{- newtype -} --{{{

reZipToList =
  let zip = ZipList [1..5]
  in  getZipList zip


--- It defining by me
newtype CharList = CharList { getCharList :: [Char] }
reCharToList =
  let char = CharList ['a'..'f']
  in  getCharList char

-- mmm... This is not optimized pattern.
data BoolList = BoolList { getBoolList :: [Bool] }
reBoolToList =
  let bool = BoolList [True, False]
  in  getBoolList bool

--}}}

{- Pairing Functor Argument -} --{{{

newtype Pair b a = Pair { getPair :: (a,b) }

instance Functor (Pair t) where
  fmap f (Pair (x,y)) = Pair (f x, y)

examTuple = (10,20)
applyFunctorSnd =
  let f = (*2)
  in  fmap f (Pair examTuple)

--}}}

{- Haskell was aboooooonnnnnnnnn!!!!!!! -} --{{{

undefList = [1, 2, undefined, 4, 5, undefined]
notAboon = head undefList
abooooon = undefList !! 2

newtype Hoge a = Hoge a
  deriving (Show)
constr _ = "Hoge"
notAboon' = constr undefined  -- because undefined was not looked up.

--}}}
