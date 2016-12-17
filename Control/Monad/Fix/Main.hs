{-# LANGUAGE RecursiveDo #-}
import Control.Monad.Fix

infZero :: MonadFix m => m [Int]
infZero = do
  rec xs <- return (0:xs)
  return xs

main :: IO ()
main = do
  xs <- take 5 <$> infZero
  print xs
