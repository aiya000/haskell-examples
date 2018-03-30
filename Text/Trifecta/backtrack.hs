{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ViewPatterns #-}

import Control.Applicative ((<|>))
import Data.ByteString (ByteString)
import Data.Text (Text)
import Text.Trifecta.Delta (delta)
import Text.Trifecta.Parser (Parser, parseString)
import Text.Trifecta.Result (Result(..), ErrInfo(..))
import qualified Data.Text as T
import qualified Text.Parser.Combinators as P
import qualified Text.Parser.Token as P

main :: IO ()
main = do
  print . flip parseIt "xyz" $ (P.textSymbol "x" >>  P.textSymbol "a") <|> P.textSymbol "xyz"
  print . flip parseIt "xyz" $ (P.try (P.textSymbol "x") >>  P.textSymbol "a") <|> P.textSymbol "xyz"
  print . flip parseIt "xyz" $ P.try (P.textSymbol "x" >>  P.textSymbol "a") <|> P.textSymbol "xyz"
-- {output}
-- Left "[Columns 1 1]"
-- Left "[Columns 1 1]"
-- Right "xyz"

parseIt :: Parser a -> Text -> Either String a
parseIt parser (T.unpack -> code) =
  case parseString parser defaultDelta code of
    Success x -> Right x
    Failure (ErrInfo _ deltas) -> Left $ show deltas
  where
    defaultDelta = delta ("" :: ByteString)
