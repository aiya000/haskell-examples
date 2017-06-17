{-# LANGUAGE TemplateHaskell #-}

import DeclareDatatype (declareNewInt)
import DeclareFunction (declareFunc, metaConst)

-- Declare id' function with DecsQ
-- $declareFunc
declareFunc

metaConst 20

declareNewInt


main :: IO ()
main = do
  print $ id' 10
  print $ constX 'a'
  print $ NewInt 30
