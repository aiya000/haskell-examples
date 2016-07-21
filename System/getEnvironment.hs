import qualified System.Environment as E
import qualified System.Posix.Env   as PE
import Data.Maybe

main :: IO ()
main = do
  x <-  E.getEnv        "EDITOR"
  x <-  E.getEnv        "EDITOR"
  y <- PE.getEnv        "EDITTTTOR"
  z <- PE.getEnvDefault "EDITTTTOR" "undefined"
  putStrLn $ x
  putStrLn $ fromMaybe "undefined" y
  putStrLn $ z
