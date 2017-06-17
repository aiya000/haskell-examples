{-# LANGUAGE TemplateHaskell #-}

import DeclareFunction (declareFunc, metaConst)

-- Declare id' function with DecsQ
-- $declareFunc
declareFunc

metaConst 10


main :: IO ()
main = do
  print $ id' 10
  print $ constX 'a'
