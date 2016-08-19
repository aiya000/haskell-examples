import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.Trans.Maybe (MaybeT(..), runMaybeT)


main :: IO ()
main = do
  x <- runMaybeT getNat
  print x

getNat :: MaybeT IO Int
getNat = do
  x <- liftIO readLn
  if x < 0
     then fail ":P"  -- same as `MaybeT $ return Nothing`
     else return x
