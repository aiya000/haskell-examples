import Control.Monad (liftM2)
import Control.Monad (MonadPlus(..))

main :: IO ()
main = do
  print $ Nothing  `mplus` return 1
  print $ return 1 `mplus` (return 2 :: Maybe Int)
  print $ Nothing  `mplus` (Nothing  :: Maybe Int)
  let x = return (return 1) :: IO (Maybe Int)
  let y = return Nothing    :: IO (Maybe Int)
  print =<< liftM2 mplus x y
