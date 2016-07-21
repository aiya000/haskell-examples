-- STRef like IORef
-- but STRef run in another thread(not main thread)
-- and STRef closed in ST `s` a
import Control.Monad.ST (ST, runST)
import Data.STRef (newSTRef, modifySTRef, readSTRef, writeSTRef)

main :: IO ()
main = do
  print $ pureFunc 1 2
  print $ runST getSTRef
  print $ runST $ do
    x <- newSTRef 10
    writeSTRef x 20  -- overwrite
    readSTRef x


-- Look like pure function
pureFunc :: Int -> Int -> Int
pureFunc x y = runST $ do
  x' <- newSTRef x
  modifySTRef x' (+ y)
  readSTRef x'


-- ST ReadWorld a <=> IO a
-- We must not indeed specify `s`
getSTRef :: ST s Int
getSTRef = do
  a <- newSTRef 0
  modifySTRef a (+10)
  readSTRef a
