import System.Random
import Control.Applicative ((<$>))

data Janken = Stone | Paper | Scissors
  deriving (Eq, Enum, Show)

data ButtleResult = Win | Lose | Tie
  deriving Show

randomInt :: RandomGen g => g -> (Int, g)
randomInt = random

instance Random Janken where
  random gen =
    let v = fst . randomInt $ gen
    in case v `mod` 3 of
            0 -> (Stone,    gen)
            1 -> (Paper,    gen)
            2 -> (Scissors, gen)
  randomR = undefined

randomIOJanken :: IO Janken
randomIOJanken = randomIO

intToJanken :: Int -> Maybe Janken
intToJanken 0 = Just Stone
intToJanken 1 = Just Paper
intToJanken 2 = Just Scissors
intToJanken x = Nothing

buttle :: Janken -> Janken -> ButtleResult
buttle Stone    Paper    = Lose
buttle Stone    Scissors = Win
buttle Paper    Stone    = Win
buttle Paper    Scissors = Lose
buttle Scissors Stone    = Lose
buttle Scissors Paper    = Win
buttle _        _        = Tie


main :: IO ()
main = do
  x <- randomIOJanken
  (Just y) <- intToJanken . read <$> getLine
  print x
  print y
  print $ x `buttle` y
