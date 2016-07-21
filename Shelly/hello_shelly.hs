{-# LANGUAGE OverloadedStrings #-}

import Shelly


main :: IO ()
main = shelly $ do
  run "git" ["log"]
  return ()
