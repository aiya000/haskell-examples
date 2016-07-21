{-# LANGUAGE OverloadedStrings #-}

import Shelly
import Control.Monad
import Control.Applicative ((<$>))
import Data.Text hiding (map, take)


main :: IO ()
main = do
  num <- read <$> getLine
  log <- shelly $ run "git" ["log", "--oneline"]
  let lines     = splitOn "\n" log
      headLines = take num lines
  mapM_ putStrLn $ map unpack headLines
