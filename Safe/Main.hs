-- See https://hackage.haskell.org/package/safe-0.3.9/docs/Safe.html
module Main where
import Safe

main :: IO ()
main = do
  print $ headMay [1..5]
  print $ headMay ([] :: [Int])
