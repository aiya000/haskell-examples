import Control.Exception.Safe (MonadCatch, try, SomeException, throwM, Exception)
import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.Morph (MMonad, embed)
import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Either (EitherT(..), runEitherT)

data AnException = AnException String
  deriving (Show)

instance Exception AnException


instance MMonad (EitherT e) where
  embed f m = EitherT $ do
    x <- runEitherT . f $ runEitherT m
    return $ case x of
      Left e          -> Left e
      Right (Left e') -> Left e'
      Right (Right a) -> Right a


check :: IO a -> EitherT SomeException IO a
check = EitherT . try

program :: (MonadCatch m, MonadIO m) => m String
program = liftIO . throwM $ AnException "nico"


main :: IO ()
main = do
  xOrErr <- runEitherT $ embed check program
  case xOrErr of
    Right x -> putStrLn $ "Success: " ++ x
    Left  y -> putStrLn $ "Left value is got !: " ++ show y


-- output
-- Left value is got !: AnException "nico"
