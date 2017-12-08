{-# LANGUAGE FlexibleContexts #-}

import GHC.Prim (coerce)
import GHC.Types (Coercible)

toInt :: Coercible a Int => a -> Int
toInt = coerce

main :: IO ()
main = return ()
