{-# LANGUAGE TemplateHaskell #-}

import Control.Lens ((^?))
import Control.Lens.Prism (Prism', prism')
import Control.Lens.TH (makePrisms)

data Mine a = My a
            | Yours
  deriving (Show)

makePrisms ''Mine


main :: IO ()
main = do
  let x = My 10 ^? _My
      y = (Yours :: Mine Int) ^? _My
  print x
  print y
