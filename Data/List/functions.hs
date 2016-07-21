import Data.List

main :: IO ()
main = do
  print $ intersperse '.' "BOOOOOOO!!"
  print $ intercalate "-" ["Hey", "Guys", "!!"]
  print $ transpose [ [1, 2, 3]
                    , [4, 5, 6]
                    , [7, 8, 9] ]
  print $ concatMap (replicate 2) [1, 2, 3]
  print $ and [True, True, False]
  print $ or  [True, True, False]
  print $ all even [1, 2, 3]
  print $ any even [1, 2, 3]
  print $ splitAt 3   [1..5]
  print $ span  (/=3) [1..5]
  print $ break (==3) [1..5]
  print $ group . sort $ "AhoAhoAhoge"
  print $ inits [1..5]
  print $ tails [1..5]
  print $ find (==3)  [1..5]
  print $ 3 `elemIndex` [1..5]
  print $ 'A' `elemIndices` "AhoAhoAhoge"
  print $ delete 'A' "AhoAhoAhoge"  -- first only
  print $ [1..10] \\ [4..6]
  print $ [1..7] `union` [5..10]
