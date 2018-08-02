{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

import Data.Proxy (Proxy(..))
import GHC.TypeLits (Nat, KnownNat, natVal, type (+))

{-

-- This is not able to instruct `natVal` can apply `n`
succ' :: forall (n :: Nat). Proxy n -> Int
succ' _ = fromInteger (natVal (Proxy :: Proxy n)) + 1

> No instance for (KnownNat n) arising from a use of 'natVal'
> ...

-}

succ' :: forall n. KnownNat n => Proxy n -> Int
succ' _ = fromInteger (natVal (Proxy :: Proxy n)) + 1

main :: IO ()
main = print $ succ' (Proxy :: Proxy 10)
