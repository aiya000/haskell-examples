module Hands
  ( Hand
  , fromHand
  , toHand
  , PokerHand
  , pokerHand
  ) where
import Cards
import Data.List

-- 手札
newtype Hand = Hand { fromHand :: [Card] }
  deriving (Show, Eq, Ord)

-- 役
data PokerHand = HighCards
               | OnePair
               | TwoPair
               | ThreeOfAKind
               | Straight
               | Flush
               | FullHouse
               | FourOfAKind
               | StraightFlush
               deriving (Show, Read, Eq, Ord, Enum)

toHand :: [Card] -> Maybe Hand
toHand cards = if length cards == 5 then Just $ Hand (sort cards)
                                    else Nothing

pokerHand :: Hand -> (PokerHand, Card)
pokerHand = undefined
