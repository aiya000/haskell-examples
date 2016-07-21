import Control.Monad.Except
import Control.Monad (when)

type InputMonad = ExceptT String IO

main :: IO ()
main = do
  input <- runExceptT getLineNotEmpty
  reportResult input

getLineNotEmpty :: InputMonad String
getLineNotEmpty = do
  x <- liftIO getLine
  when (null x) $ do
    throwError "null"
  return x

reportResult :: Either String String -> IO ()
reportResult (Right r) = putStrLn $ "input: " ++ r
reportResult (Left  l) = putStrLn $ "bad input (" ++ l ++ ")"
