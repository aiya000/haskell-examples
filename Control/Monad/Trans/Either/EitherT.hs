{-# LANGUAGE ScopedTypeVariables #-}

import Control.Monad.Catch
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Trans (liftIO)
import Control.Monad.Trans.Either

data StringFail = StringEmpty deriving (Show)
instance Exception StringFail


main :: IO ()
main = do
  Right x <- runEitherT $ getLineNotEmpty `catch` \(e :: SomeException) -> return "alternative string"
  putStr "x value is always right: "
  print x

getLineNotEmpty :: (MonadCatch m, MonadIO m) => m String
getLineNotEmpty = do
  s <- liftIO getLine
  if (null s)
     then throwM StringEmpty
     else return s
