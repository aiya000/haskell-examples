import Control.Monad.State
import Control.Monad.Identity

foo  :: StateT Int Identity Int
foo   = StateT $ \s -> return (s + 1, s)
hoge :: Int -> Identity (Int, Int)
hoge  = runStateT foo
bar  :: Identity (Int, Int)
bar   = hoge 10

main :: IO ()
main = print . runIdentity $ bar
