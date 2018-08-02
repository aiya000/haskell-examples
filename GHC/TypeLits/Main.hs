{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

import Data.Proxy (Proxy(..))
import GHC.TypeLits (natVal, type (+), symbolVal)

main :: IO ()
main = do
  print $ natVal (Proxy :: Proxy 10)
  print $ natVal (Proxy :: Proxy (20 + 30))
  putStrLn $ symbolVal (Proxy :: Proxy "poi")
