import Control.Monad.Extra (ifM)
import System.Directory (doesFileExist)

main :: IO ()
main = do
  x <- ifM (doesFileExist "aho") (return "yes aho") (return "no aho")
  print x
