{-# LANGUAGE FlexibleInstances #-}

import Data.Functor.Identity (Identity(..))
import Data.Distributive (Distributive(..))

x :: Maybe (Identity Int)
x = Just $ Identity 10

y :: Identity (Maybe Int)
y = distribute x


main :: IO ()
main = do
  print x
  print y
