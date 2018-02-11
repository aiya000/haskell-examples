{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

import Data.Proxy (Proxy(..))
import GHC.TypeLits

data Vect (n :: Nat) a :: * where
  Nil :: Vect 0 a
  (:::) :: a -> Vect n a -> Vect (n + 1) a

infixr 7 :::

xs :: Vect 5 Int
xs = 1 ::: 2 ::: 3 ::: 4 ::: 5 ::: Nil

-- HaskellではNatが値を持たないのでIntを使う
length' :: forall n a. KnownNat n => Vect n a -> Int
length' _ = fromInteger $ natVal (Proxy :: Proxy n)

main :: IO ()
main = print $ length' xs
-- {output}
-- 5
