import Control.Applicative

main = do
  a     <- (map read . words) <$> getLine
  [b,c] <- (map read . words) <$> getLine
  putStrLn $ show (a :: [Int])
  let iPutStrLn x y = putStrLn $ show ((x+y) :: Int)
  iPutStrLn b c
