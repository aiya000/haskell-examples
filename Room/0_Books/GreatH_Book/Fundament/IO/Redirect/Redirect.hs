import Data.Char

main = do
  txt <- getLine
  putStrLn $ map toUpper txt
