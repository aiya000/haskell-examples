main :: IO ()
main = do
  print $ and [True, True, True, True]
  print $ and [True, True, True, False]
  print $ or  [True, True, True, True]
  print $ or  [True, True, True, False]
