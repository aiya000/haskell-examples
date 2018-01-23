{-# LANGUAGE RebindableSyntax #-}

import Prelude (Integer, String, IO, print, ($), (==))

fromInteger :: Integer -> String
fromInteger _ = "x"

main :: IO ()
main = print $ 1 == "x"
-- {output}
-- True
