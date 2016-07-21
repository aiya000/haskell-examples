import Control.Monad.Writer

tellIt :: Show a => a -> Writer [String] a
tellIt x = do
  tell ["this is " ++ show x]
  return x

main :: IO ()
main = do
  print $ runWriter (return 10 >>= tellIt >>= \x -> tellIt (x + 10))
