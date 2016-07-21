import System.Random
import Control.Monad

mkRandConstant = do
  forM_ [0..3] $ \i -> do
    let (rand, _) = random (mkStdGen 100) :: (Int, StdGen)
    print rand

mkRandConstantGen = do
  let (a, fstGen) = random (mkStdGen 100)
      (b, sndGen) = random fstGen
      (c, ______) = random sndGen :: (Int, StdGen)
  putStrLn $ show [a,b,c]


mkRandListConstant = do
  let randList = take 3 $ randoms (mkStdGen 100) :: [Int]
  putStrLn $ show randList

mkRandByRangeConstant = do
  let (rand, _) = randomR (0, 10) (mkStdGen 100) :: (Int, StdGen)
  print rand

mkRandByRangeListConstant = do
  let randList = take 3 $ randomRs (0, 10) (mkStdGen 100) :: [Int]
  putStrLn $ show randList


mkRandGlobal = do
  _ <- getStdGen
  forM_ [0..2] $ \i -> do
    gen <- getStdGen
    let (rand, _) = random gen :: (Int, StdGen)
    print rand
  putStrLn "mmm...\n"

  forM_ [0..2] $ \i -> do
    gen <- newStdGen
    let (rand, _) = random gen :: (Int, StdGen)
    print rand
  putStrLn "Oh, good!!"
