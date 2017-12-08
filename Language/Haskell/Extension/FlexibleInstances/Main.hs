{-# LANGUAGE FlexibleInstances #-}

class Identical a where
  id' :: a -> a
  id' = id

data Foo a = Foo
  deriving (Show)

-- An instance of the part
instance Identical (Foo Int)

main :: IO ()
main = do
  print $ id' (Foo :: Foo Int)
  --print $ id' (Foo :: Foo Char)
