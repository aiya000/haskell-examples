import Data.HashSet (empty)
import Text.Parser.Char (lower, letter)
import Text.Parser.Token (TokenParsing, IdentifierStyle(..), ident)
import Text.Parser.Token.Highlight (Highlight(..))
import Text.Trifecta.Parser (Parser(..), parseTest)

identifier :: String
identifier = "koNoKo"

partial :: String
partial = "sugar + cover"

notIdentifier :: String
notIdentifier = "<>"

main :: IO ()
main = do
  parseTest identifierParser identifier
  parseTest identifierParser partial
  parseTest identifierParser notIdentifier


identifierParser :: (TokenParsing m, Monad m) => m String
identifierParser = ident camelCase
  where
    camelCase = IdentifierStyle { _styleName              = "camelCase"
                                , _styleStart             = lower
                                , _styleLetter            = letter
                                , _styleReserved          = empty
                                , _styleHighlight         = Identifier
                                , _styleReservedHighlight = Identifier
                                }
-- -- {output}
-- "koNoKo"
-- "sugar"
-- [1m(interactive)[0m:[1m1[0m:[1m1[0m: [91merror[0m: expected: camelCase
-- <>[1m[94m<EOF>[0;1m[0m 
-- [92m^[0m       
