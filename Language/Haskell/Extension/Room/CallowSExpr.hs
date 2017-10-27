{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE ViewPatterns #-}

data SExpr = Cons SExpr SExpr | AtomInt Int
  deriving (Show)

newtype CallowSExpr = CallowSExpr { growUp :: SExpr }
  deriving (Show)

-- uni-directional synonyms
pattern AtomInt' :: Int -> CallowSExpr
pattern AtomInt' x = CallowSExpr (AtomInt x)

pattern LightCons' :: SExpr -> SExpr -> CallowSExpr
pattern LightCons' x y = CallowSExpr (Cons x y)

-- explicitly-bidirectional pattern synonyms
pattern Cons' :: CallowSExpr -> CallowSExpr -> CallowSExpr
pattern Cons' x y <- LightCons' (CallowSExpr -> x) (CallowSExpr -> y)
  where
    Cons' a b = LightCons' (growUp a) (growUp b)


main :: IO ()
main = do
  let x = Cons' (AtomInt' 1) (AtomInt' 2)
  print x
-- {output}
-- CallowSExpr {growUp = Cons (AtomInt 1) (AtomInt 2)}
