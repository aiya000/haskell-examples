import Data.Char

-- get only redirect input
main = do
  content <- getContents
  putStrLn $ map toUpper content
