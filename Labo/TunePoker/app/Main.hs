module Main where
import Data.List
import Lib
import System.Random.Shuffle

main :: IO ()
main = do
  shuffled <- shuffleM allCards
  print . sort . take 5 $ shuffled
