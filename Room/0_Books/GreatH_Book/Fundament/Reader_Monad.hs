import Control.Applicative


--- Reader Monad is a Monadic Function

addStuff0  = (+) <$> (*2) <*> (+10)
applyExpr0 = addStuff0 3

addStuff1  = do
  a <- (*2)
  b <- (+10)
  return (a+b)
applyExpr1 = addStuff1 3


exprList = [applyExpr0, applyExpr1]
main = putStrLn . show $ exprList
