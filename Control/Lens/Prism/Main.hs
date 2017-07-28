{-# LANGUAGE LambdaCase #-}

import Control.Lens ((^?))
import Control.Lens.Prism

data Mine a = My a
            | Yours
  deriving (Show)


my :: Prism' (Mine a) a
my = prism' My $ \case
  My x -> Just x
  Yours -> Nothing


main :: IO ()
main = do
  let x = My 10 ^? my
      y = (Yours :: Mine Int) ^? my
  print x
  print y
