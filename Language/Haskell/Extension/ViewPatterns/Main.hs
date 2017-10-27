{-# LANGUAGE ViewPatterns #-}

newtype TXT = TXT { naked :: String }
  deriving (Show)

-- Basic
size :: [a] -> Int
size (length -> x) = x

txt :: String -> TXT
txt (TXT -> x) = x


main :: IO ()
main = do
  print $ size [0..4]
  print $ txt "hi"
