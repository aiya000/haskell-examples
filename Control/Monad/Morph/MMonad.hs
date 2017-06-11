import Control.Exception.Safe (MonadThrow, try, SomeException, throwM, Exception)
import Control.Monad (join)
import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.Morph (MMonad, embed)
import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Either (EitherT(..), runEitherT)

data AnException = AnException String
  deriving (Show)

instance Exception AnException


instance MMonad (EitherT e) where
  embed f m = EitherT $ do
    let nee = runEitherT . f $ runEitherT m -- :: n (Either e (Either e a))
    join <$> nee


check :: IO a -> EitherT SomeException IO a
check = EitherT . try

program :: (MonadThrow m, MonadIO m) => m String
program = liftIO . throwM $ AnException "nico"


main :: IO ()
main = do
  xOrErr <- runEitherT $ embed check program
  case xOrErr of
    Right x -> putStrLn $ "Success: " ++ x
    Left  y -> putStrLn $ "Left value is got !: " ++ show y


-- output
-- Left value is got !: AnException "nico"
