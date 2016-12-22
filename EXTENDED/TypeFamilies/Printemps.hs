{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

-- This code respects tecno_tanoC's code

class LoveLiveSubUnit a b c where
  type Members a b c
  unitName :: a -> b -> c -> Members a b c
  -- ^
  -- The type function must inject its type arguments.
  -- For example, this is not allowed
  -- unitName :: Members a b c

data Honoka    = Honoka deriving (Show)
data Kotori    = Kotori deriving (Show)
data Hanayo    = Hanayo deriving (Show)
data Printemps = Printemps deriving (Show)

instance LoveLiveSubUnit Honoka Kotori Hanayo where
  type Members Honoka Kotori Hanayo = Printemps
  unitName _ _ _ = Printemps


main :: IO ()
main = do
  print $ unitName Honoka Kotori Hanayo
  -- These to be compile error
  --print $ unitName 1 2 3
  --print $ unitName Kotori Honoka Hanayo
