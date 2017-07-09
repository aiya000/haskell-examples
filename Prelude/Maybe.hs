context :: Maybe ()
context = do
  Just x <- (Nothing :: Maybe (Maybe Int))
  x `seq` return ()


main :: IO ()
main = print context
