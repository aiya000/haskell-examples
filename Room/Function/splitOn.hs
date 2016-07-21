main :: IO ()
main = do
  let xs = splitOn ',' "ABC,DEF,GHI,JKL"
      ys = splitOn 0   [11,12,0,13,14,0,15,16]
  print xs
  print ys

splitOn :: (Eq a) => a -> [a] -> [[a]]
splitOn delim xs = body xs []
  where
    body []     results = [results]
    body (y:ys) results | y == delim = results : body ys []
                        | otherwise  = body ys (results ++ [y])
