{-# LANGUAGE TemplateHaskell #-}

import Control.Lens

data Term = TermInt Int
          | TermBool Bool
  deriving (Show)

makePrisms ''Term

mixed :: [Term]
mixed = [TermInt 10, TermBool True, TermInt 20, TermBool False]

onlyInt :: [Term]
onlyInt = [TermInt 10, TermInt 20]


main :: IO ()
main = do
  print $ mixed ^.. folded . _TermInt
  print $ onlyInt ^.. folded . _TermBool
  print $ mixed ^.. folded . filtered (not . isTermInt) 
-- [10,20]
-- []
-- [TermBool True,TermBool False]


isTermInt :: Term -> Bool
isTermInt (TermInt _) = True
isTermInt _ = False
