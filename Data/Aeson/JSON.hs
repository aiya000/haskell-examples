{-# LANGUAGE OverloadedStrings #-}
import Data.Aeson
import Data.Maybe ( fromJust )
import Data.Text ( Text () )
import Data.ByteString.Lazy ( ByteString () )
import qualified Data.ByteString.Lazy as BLazy

data Timeline = Timeline
  { _text :: Text
  } deriving (Show)

instance FromJSON Timeline where
  parseJSON (Object v) = Timeline <$> v .: "text"

type Timelines = [Timeline]

decode'' :: ByteString -> Maybe Timelines
decode'' = decode

main :: IO ()
main = do
  jsonStr <- BLazy.readFile "JSON.json"
  let timeline = map _text . fromJust . decode'' $ jsonStr
  print timeline
