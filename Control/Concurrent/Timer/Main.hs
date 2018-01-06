import Control.Concurrent.Suspend (sDelay)
import Control.Concurrent.Timer (TimerIO, newTimer, repeatedStart)
import Control.Monad (when, void)

main :: IO ()
main = do
  x <- newTimer
  y <- newTimer
  succeed  <- repeatedStart x (putStrLn "x") $ sDelay 1
  succeed' <- repeatedStart y (putStrLn "y") $ sDelay 1
  when (not succeed || not succeed') $ error "poi"
  void getLine
-- {output}
-- x
-- y
-- y
-- x
-- ...
