{-# LANGUAGE TemplateHaskell #-}
import Control.Monad.Logger
import Control.Monad.Identity (Identity)
import Data.Text (pack)
import Control.Monad.IO.Class (MonadIO)


main :: IO ()
main = do
  x <- runStdoutLoggingT $ add 1 1
  print x


-- LoggingT needs MonadIO
add :: MonadIO m => Int -> Int -> LoggingT m Int
add x y = do
  $logInfo $ pack . ("result = " ++) . show $ x + y
  return $ x + y
