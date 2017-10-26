{-# LANGUAGE LambdaCase #-}

import Control.Lens ((^?), (&), (.~))
import Control.Lens.Prism (Prism', prism')

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
  print x
  let y = (Yours :: Mine Int) ^? my
  print y
  let x' = (Yours :: Mine Int) & my .~ 20
  print x'
