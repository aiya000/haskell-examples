{-# LANGUAGE OverloadedStrings #-}

import Data.String (IsString(..))

data Foo = Foo

instance IsString Foo where
  fromString _ = Foo

instance Num Foo where
  fromInteger _ = Foo

instance Eq Foo where
  _ == _ = True

default (Foo)

main :: IO ()
main = print $ 1 == "x"
-- {output}
-- True
