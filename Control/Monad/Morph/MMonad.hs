import Control.Exception.Safe (MonadCatch, try, SomeException)
import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.Morph (embed)
import Control.Monad.Trans.Class (lift)
import Control.Monad.Except (ExceptT(..), runExceptT)


check :: IO a -> ExceptT SomeException IO a
check = ExceptT . try

program :: (MonadCatch m, MonadIO m) => m String
program = liftIO $ readFile ""


main :: IO ()
main = do
  xOrErr <- runExceptT $ embed check program
  case xOrErr of
    Right x -> putStrLn $ "Success: " ++ x
    Left  y -> putStrLn $ "Left value is got !: " ++ show y
