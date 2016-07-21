data Days = Sun | Mon | Tue | Wed | Thu | Fri | Sut
  deriving (Show, Enum)

days = [Sun .. Sut]
easyCal :: Int -> IO ()
easyCal 32 = return ()
easyCal x = do
  putStr   $ show x
  putStr   " | "
  putStrLn $ show $ days !! (x `mod` 7)
  easyCal $ x + 1
main = easyCal 1
