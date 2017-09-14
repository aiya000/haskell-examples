import Control.Exception (ArithException(..), IOException)
import Control.Exception.Safe (MonadThrow, throwM, catches, Handler(..))
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Trans.Either (runEitherT)

context :: (MonadThrow m, MonadIO m) => m a
context = throwM Overflow

main :: IO ()
main = do
  context `catches` [ Handler handleIOException
                    , Handler handleArithException
                    ]
  where
    handleIOException :: IOException -> IO ()
    handleIOException _ = putStrLn "IOException is detected"

    handleArithException :: ArithException -> IO ()
    handleArithException _ = putStrLn "alice"
