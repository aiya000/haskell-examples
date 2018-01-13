{-# LANGUAGE QuasiQuotes #-}

import Data.Text (Text)
import Text.QuasiText (embed)
import qualified Data.Text.IO as T

x :: Text
x = [embed|ya|]

y :: Text
y = [embed| ya
hi
poi
|]

-- cannot
--z :: String
--z = [embed|ppppoi|]

main :: IO ()
main = do
  T.putStrLn x
  T.putStrLn y
