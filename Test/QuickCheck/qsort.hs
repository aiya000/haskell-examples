-- see http://book.realworldhaskell.org/read/testing-and-quality-assurance.html
import qualified Test.QuickCheck as Q
import Control.Exception (SomeException,catch)

main :: IO ()
main = do
  putStrLn ">> First test"
  testQSort `catch` print'
  putStrLn "\n>> Second test"
  testFixedQSort `catch` print'

print' :: SomeException -> IO ()
print' e = putStrLn $ "Exception: " ++ show e

qsort :: Ord a => [a] -> [a]
qsort (x:xs) = smaller ++ [x] ++ larger
  where
    larger  = filter (x >)  xs
    smaller = filter (x <=) xs

equalsMultiply :: [Integer] -> Bool
equalsMultiply xs = qsort (qsort xs) == qsort xs

testQSort :: IO ()
testQSort = Q.quickCheck equalsMultiply


-- This is real mistake...
fixedQSort :: Ord a => [a] -> [a]
fixedQSort []     = []
fixedQSort [x]    = [x]
fixedQSort (x:xs) = fixedQSort smaller ++ [x] ++ fixedQSort larger
  where
    larger  = filter (x >)  xs
    smaller = filter (x <=) xs

equalsMultiply0 :: [Integer] -> Bool
equalsMultiply0 xs = (fixedQSort . fixedQSort $ xs) == fixedQSort xs

testFixedQSort :: IO ()
testFixedQSort = Q.quickCheck equalsMultiply0
