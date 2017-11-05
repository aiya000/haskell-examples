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
main = return ()
