import Control.Error
import Control.Monad.Trans (liftIO)
import Control.Monad.Trans.Either

data StringFail = StringEmpty deriving (Show)


main :: IO ()
main = do
  e <- runEitherT getLineNotEmpty
  reportResult e

getLineNotEmpty :: EitherT StringFail IO String
getLineNotEmpty = do
  s <- liftIO getLine
  if (null s)
     then left StringEmpty
     else return s

reportResult :: Either StringFail String -> IO ()
reportResult (Right r) = putStrLn $ "input: " ++ r
reportResult (Left l)  = putStrLn $ "bad input (" ++ (show l) ++ ")"
