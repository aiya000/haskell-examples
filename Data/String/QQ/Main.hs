{-# LANGUAGE QuasiQuotes #-}

import Data.String.QQ (s)
import Data.Text (Text)
import qualified Data.Text.IO as T

x :: String
x = [s|ya|]

y :: Text
y = [s|po|]

z :: Text
z = [s|p
      p
      poi
      |]

main :: IO ()
main = do
  putStrLn x
  T.putStrLn y
  T.putStrLn z
