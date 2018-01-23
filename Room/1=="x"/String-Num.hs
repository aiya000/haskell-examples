{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}

instance Num String where
  fromInteger _ = "x"

default (String)

main :: IO ()
main = print $ 1 == "x"
-- {output}
-- True
