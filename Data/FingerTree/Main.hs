-- What is this ?
-- :)

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeSynonymInstances #-}

import Data.FingerTree
import Data.Monoid (Sum)

type SumInt = Sum Int

instance Measured SumInt SumInt where
  measure x = x

type IntZipper = FingerTree SumInt SumInt


main :: IO ()
main = do
  let x0 :: IntZipper
      x0 = fromList [1,2,3,4,5]
      x1 = 0 <| x0
      x2 = x1 |> 6
  print x0
  print x1
  print x2
