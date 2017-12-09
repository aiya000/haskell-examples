{-# LANGUAGE InstanceSigs #-}

class Identical a where
  id' :: a -> a

instance Identical Int where
  -- InstanceSigs allows this type declaration
  id' :: Int -> Int
  id' = id

main :: IO ()
main = return ()
