import Data.List

main = print $ divideInto 3 [1..10]

divideInto :: Int -> [a] -> [[a]]
divideInto n xs = unfoldr (\xs -> if null xs then Nothing else Just $ splitAt m xs) xs
  where m = ((length xs) + n - 1) `div` n
