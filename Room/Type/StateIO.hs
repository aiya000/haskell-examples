-- See http://qiita.com/7shi/items/4408b76624067c17e933
import Control.Monad
import Control.Monad.State

main :: IO ()
main = sum' [1..10] >>= print

sum' xs = (`execStateT` 0) $ do
  forM_ xs $ \i -> do
    modify (+i)
    v <- get
    lift $ putStrLn (show i ++ "\t|-> " ++ show v)
