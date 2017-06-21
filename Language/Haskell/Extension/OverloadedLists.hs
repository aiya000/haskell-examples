{-# LANGUAGE OverloadedLists #-}

import Data.Map (Map)
import Data.Set (Set)
import Data.Text (Text)

xs :: Set Int
xs = [1..9]

ys :: Map String Int
ys = [ ("ahoge", 10)
     , ("hogea", 20)
     ]

zs :: Text
zs = ['a' .. 'z']


main :: IO ()
main = return ()
