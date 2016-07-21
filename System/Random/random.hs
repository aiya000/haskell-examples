import System.Random

randomInt :: RandomGen g => g -> (Int, g)
randomInt = random

randomIntR :: RandomGen g => (Int, Int) -> g -> (Int, g)
randomIntR = randomR

randomIOInt :: IO Int
randomIOInt = randomIO

main :: IO ()
main = do
  printPureRandoms
  putStrLn "- - -"
  printInpureRandoms

printPureRandoms :: IO ()
printPureRandoms = do
  gen <- newStdGen
  let (x, gen') = randomInt gen
      (x', _)   = randomInt gen
      (y, _)    = randomInt gen'
      (z, _)    = randomIntR (1,10) gen'
  print x
  print y
  print $ x == x'
  print z

printInpureRandoms :: IO ()
printInpureRandoms = do
  x <- getStdRandom randomInt
  y <- getStdRandom (randomIntR (1, 10))
  z <- randomIOInt
  print x
  print y
  print z
