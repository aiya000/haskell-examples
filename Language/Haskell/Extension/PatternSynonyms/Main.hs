{-# LANGUAGE PatternSynonyms #-}

data SExpr = Cons SExpr SExpr | AtomInt Int

newtype CallowSExpr = CallowSExpr { growup :: SExpr }

pattern Cons' :: SExpr -> SExpr -> CallowSExpr
pattern Cons' x y = CallowSExpr (Cons x y)

main :: IO ()
main = do
  let x = Cons' (AtomInt 1) (AtomInt 2)
  return ()
