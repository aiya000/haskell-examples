{-# LANGUAGE TypeApplications #-}

import Control.Applicative ((<|>))
import Data.Void (Void)
import Text.Megaparsec (Parsec, parseTest, parse)
import qualified Control.Applicative as P
import qualified Text.Megaparsec.Char as P

type Parser = Parsec Void String

parseVisibility :: Parser String
parseVisibility =
    P.string "private" <|>
    P.string "protected" <|>
    P.string "public"

parseClassKind :: Parser String
parseClassKind =
    P.string "abstract" <|>
    P.string "final" <|>
    P.string "sealed"

blank :: Parser String
blank = P.many P.spaceChar

token :: Parser String -> Parser String
token parseWord = do
  blank
  word <- parseWord
  blank
  pure word

parseClass :: Parser String
parseClass = do
  P.optional $ token parseVisibility
  P.many $ token parseClassKind
  P.optional . token $ P.string "data"
  token $ P.string "class"
  name <- P.many $ P.alphaNumChar <|> P.char '_'
  P.many P.anyChar
  pure name

main :: IO ()
main = do
  let parseTest' = parseTest @Void @String
  parseTest' parseClass "public data class You(val me: String)"
  parseTest' parseClass "sealed class Product {}"
-- {output}
-- "You"
-- "Product"
