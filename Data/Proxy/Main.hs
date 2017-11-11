{-# LANGUAGE DataKinds #-}

import Data.Proxy (Proxy(..))
import Data.Typeable (typeRep)
import Data.Void (Void)
import GHC.TypeLits (Nat, natVal, Symbol, symbolVal)

main :: IO ()
main = do
  print $ typeRep (Proxy :: Proxy Void)
  print $ natVal (Proxy :: Proxy 10)
  print $ symbolVal (Proxy :: Proxy "poi")
-- {output}
-- Void
-- 10
-- "poi"
