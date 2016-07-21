import System.Random (newStdGen)
import System.Random.Shuffle

-- See hackage 'random-shuffle'
--- shuffle, shuffle', shuffleM

doShuffle' =  do
  gen <- newStdGen
  let xs = ['a'..'z']
  return $ shuffle' xs (length xs) gen

main :: IO ()
main = do
  xs <- shuffleM [1..10]
  print xs
  ys <- doShuffle'
  print ys
