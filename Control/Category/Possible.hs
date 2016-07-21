-- See http://qiita.com/CyLomw/items/ff1e5d1600291c952c5e

import Prelude hiding ((.), id)
import Control.Category
import Control.Monad


newtype Possible i o = Possible { runPossible :: i -> Maybe o }

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeHead' :: Possible [a] a
safeHead' = Possible safeHead

twiceNatural :: Int -> Maybe Int
twiceNatural x | x < 0     = Nothing
               | otherwise = Just $ x * 2
twiceNatural' :: Possible Int Int
twiceNatural' = Possible twiceNatural

instance Category Possible where
  (.) (Possible f) (Possible g) = Possible $ join . fmap f . g
  id = Possible $ \x -> Just x


justCase    :: Maybe Int
justCase    = runPossible (twiceNatural' >>> twiceNatural') 1
nothingCase :: Maybe Int
nothingCase = runPossible (twiceNatural' >>> twiceNatural') (-1)
