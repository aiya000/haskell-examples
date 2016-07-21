import Data.Array.IO
import Control.Monad

toList :: IOArray Int Int -> Int ->  Int -> IO [(Int, Int)]
toList array start len = do
  xs <- flip mapM [start..len] $ \i -> do
    x <- readArray array i
    return (i,x)
  return xs


main :: IO ()
main = do
  let start = 0
      len   = 4
  array <- newArray (start, len) 10 :: IO (IOArray Int Int)
  toList array start len >>= print
  writeArray array 2 20
  toList array start len >>= print
  arrray <- newListArray (start, len) [1,3,2,5,4]
  toList arrray start len >>= print
