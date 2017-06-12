{-# LANGUAGE OverloadedStrings #-}

import Data.Profunctor (dimap)
import Data.Text (Text)
import qualified Data.Text as T


x :: Text
x = "kotori"

main :: IO ()
main = print $ dimap T.unpack T.pack (++ "-chan") x
