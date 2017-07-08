{-# LANGUAGE MultiParamTypeClasses #-}

import Data.Coerce (Coercible, coerce)
import Control.Monad.Identity (Identity(..))

main :: IO ()
main = print . (coerce :: Identity Int -> Int) $ Identity 10
