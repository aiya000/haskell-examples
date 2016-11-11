module Main where

import Control.Applicative (Alternative((<|>)))
import Data.Functor.Identity (Identity, runIdentity)
import qualified Data.Attoparsec.Text as P


parse :: P.Parser () -> String -> Maybe ()
parse parser str = either (const Nothing) Just $ P.parseOnly parser str

registersOrRegParse :: String -> Maybe ()
registersOrRegParse = Main.parse $ do
  void $ P.try (P.string "registers") <|> P.try (P.string "reg")
  return ()

main :: IO ()
main = do
  print $ Main.parse registersOrRegParse "register"
  print $ Main.parse registersOrRegParse "reg"
  print $ Main.parse registersOrRegParse "banana"
