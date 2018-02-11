{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}

import Data.Proxy (Proxy(..))
import GHC.TypeLits

type family Succ (n :: Nat) :: Nat where
  Succ n = n + 1

type A = Succ 0
type B = Succ 10 -- 🤔

main :: IO ()
main = do
  print $ natVal (Proxy :: Proxy 1)
  print $ natVal (Proxy :: Proxy (Succ 1))
  print $ natVal (Proxy :: Proxy A)
  print $ natVal (Proxy :: Proxy B)
-- {output}
-- 1
-- 2
-- 1
-- 11
