{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE ViewPatterns #-}

data SExpr = Cons SExpr SExpr | AtomInt Int
  deriving (Show)

newtype CallowSExpr = CallowSExpr { growUp :: SExpr }
  deriving (Show)

-- uni-directional synonyms
pattern AtomInt' :: Int -> CallowSExpr
pattern AtomInt' x = CallowSExpr (AtomInt x)

-- explicitly-bidirectional pattern synonyms
pattern Cons' :: CallowSExpr -> CallowSExpr -> CallowSExpr
pattern Cons' x y <- CallowSExpr (Cons (CallowSExpr -> x) (CallowSExpr -> y))
  where
    Cons' a b = CallowSExpr (Cons (growUp a) (growUp b))


main :: IO ()
main = do
  let x = Cons' (AtomInt' 1) (AtomInt' 2)
  print x
-- {output}
-- CallowSExpr {growUp = Cons (AtomInt 1) (AtomInt 2)}
