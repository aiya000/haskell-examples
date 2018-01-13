{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

import Data.String.Here.Interpolated (i)
import Data.Text (Text)
import qualified Data.Text.IO as T

x :: String
x = let z = 10 :: Int
    in [i|hi ${z}|]

y :: Text
y = let z = 20 :: Int
    in [i|hi ${z}|]

main :: IO ()
main = do
  putStrLn x
  T.putStrLn y
