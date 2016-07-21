import System.Environment

main = do
  progName <- getProgName
  args <- getArgs
  putStrLn $ "This Program Name is [" ++ progName ++ "]."
  putStrLn $ "Command Line Arguments is " ++ (show args) ++ "."
