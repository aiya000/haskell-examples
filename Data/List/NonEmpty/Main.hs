{-# LANGUAGE OverloadedLists #-}

import Data.List.NonEmpty (NonEmpty, (<|))

xs :: NonEmpty Int
xs = [30]

main :: IO ()
main = print $ 10 <| 20 <| xs
