{-# LANGUAGE FlexibleInstances #-}

class One a where
  id' :: a -> a
  id' = id

data High a = High deriving (Show)

-- An instance for partial High (FlexibleInstances)
instance One (High Int)


main :: IO ()
main = do
  print . id' $ (High :: High Int)
  --print . id' $ (High :: High Char)
