import System.Process

main :: IO ()
main = do
  items <- readProcess "ls" ["-l", "-a"] ""
  putStrLn items
