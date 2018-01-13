{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

import Data.String.Interpolate (i)
import qualified Data.Text.IO as T

main :: IO ()
main = do
  let x = "me"
  putStrLn [i|hello #{x}|]
  --T.putStrLn [i|hello #{x}|]
