import Text.Regex.Posix

main :: IO ()
main = do
  print ("abc" =~ "b" :: Bool)
  print ("abc" =~ "b" :: Int)
  print ("abc" =~ "b" :: String)
