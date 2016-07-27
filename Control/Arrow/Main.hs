{-# LANGUAGE Arrows #-}

import Control.Arrow (returnA)

-- Arrow notation needs 'proc'
idA :: a -> a
idA = proc a -> returnA -< a

plusOne :: Int -> Int
plusOne = proc a -> returnA -< (a + 1)

plusTwo :: Int -> Int
plusTwo = proc a -> plusOne -< (a + 1)

plusTwo' :: Int -> Int
plusTwo' = proc a -> do
  b <- plusOne -< a
  plusOne -< b

main :: IO ()
main = do
  print $ idA      10
  print $ plusOne  10
  print $ plusTwo  10
  print $ plusTwo' 10
