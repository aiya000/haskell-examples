-- See http://qiita.com/7shi/items/4408b76624067c17e933
import Control.Monad

x = Just 10
y = Just 20

main :: IO ()
main = do
  print $ liftM (+1) x
  print $ liftM2 (+) x y  -- liftM2 for binary operator
