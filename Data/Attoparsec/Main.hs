{-# LANGUAGE OverloadedStrings #-}

-- Thanks for writing this @mizunashi-mana :D

module Main where

import Control.Applicative
import qualified Data.Attoparsec.Text as P
import qualified Data.Text as T

scanString :: T.Text -> P.Parser T.Text
scanString = foldr1 (flip (<|>)) . map (P.try . P.string) . T.inits

-- use scanString version
registersParser = P.string "reg" <* scanString "isters"

-- use primitive scan parser version
registersParser' = P.string "reg" <* P.scan "isters" scanStr
  where
    scanStr ""     _ = Nothing
    scanStr (x:xs) c
      | x == c       = Just xs
      | otherwise    = Nothing

parseInput :: P.Parser a -> T.Text -> Either String a
parseInput p = P.parseOnly $ p <* P.endOfInput

registersParse :: T.Text -> Either String T.Text
registersParse = parseInput registersParser

registersParse' :: T.Text -> Either String T.Text
registersParse' = parseInput registersParser'

main :: IO ()
main = do
  print $ registersParse "rex"         -- Left
  print $ registersParse "reg"         -- Right
  print $ registersParse "regist"      -- Right
  print $ registersParse "register"    -- Right
  print $ registersParse "registerg"   -- Left
  print $ registersParse "registers"   -- Right
  print $ registersParse "registerss"  -- Left
