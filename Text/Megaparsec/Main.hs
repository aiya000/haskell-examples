{-# LANGUAGE TypeApplications #-}

import Data.Void (Void)
import Text.Megaparsec (parseTest, parse)
import qualified Control.Applicative as P
import qualified Text.Megaparsec.Char as P
import qualified Text.Megaparsec.Char.Lexer as P hiding (space)

main :: IO ()
main = do
  (parseTest @Void @String) parser "hi 10"
  print $ parse parser "no-name" "hi 10"
  print $ parse parser "no-name" "10"
  where
    parser = do
      hi <- P.many P.alphaNumChar
      P.space
      _10 <- P.decimal
      pure (hi, _10)
-- {output}
-- ("hi",10)
-- Right ("hi",10)
-- Left (TrivialError (SourcePos {sourceName = "no-name", sourceLine = Pos 1, sourceColumn = Pos 3} :| []) (Just EndOfInput) (fromList [Label ('a' :| "lphanumeric character"),Label ('i' :| "nteger"),Label ('w' :| "hite space")]))
