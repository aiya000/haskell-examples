module Cards
  ( Card
  , Suit (..)
  , allCards
  , cardSuit
  , cardNumber
  ) where

data Card = Card Int Suit
  deriving (Eq, Ord)

data Suit = Hearts | Diamonds | Clubs | Speads
  deriving (Show, Read, Eq, Ord, Enum)

showCardNumber :: Int -> String
showCardNumber 14 = "A_"
showCardNumber 13 = "K_"
showCardNumber 12 = "Q_"
showCardNumber 11 = "J_"
showCardNumber 10 = "10"
showCardNumber x  = show x ++ "_"

instance Show Card where
  show (Card i Hearts)   = "H" ++ showCardNumber i
  show (Card i Diamonds) = "D" ++ showCardNumber i
  show (Card i Clubs)    = "C" ++ showCardNumber i
  show (Card i Speads)   = "S" ++ showCardNumber i

allCards :: [Card]
allCards = [ Card num suit | num <- [2..14], suit <- [Hearts ..]]


cardSuit :: Card -> Suit
cardSuit (Card _ s) = s

cardNumber :: Card -> Int
cardNumber (Card n _) = n
