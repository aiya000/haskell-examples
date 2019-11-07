main :: IO ()
main = do
  print x
  print y
  where
    (x, y) = (10, 20)
