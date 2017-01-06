import Data.Tuple.Extra ((&&&))

main :: IO ()
main = do
  print $ ((+1) &&& (+2)) 0
