{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Proxy (Proxy(..))
import GHC.TypeLits (Nat, natVal, KnownNat)

data Foo = Bar Nat

data SFoo = SBar Int
  deriving (Show)

type family ExtractNat (a :: Foo) :: Nat where
  ExtractNat (Bar x) = x

sing :: forall a. KnownNat (ExtractNat a) => Proxy a -> SFoo
sing _ = SBar . fromInteger $ natVal (Proxy :: Proxy (ExtractNat a))

main :: IO ()
main = print $ sing (Proxy :: Proxy (Bar 10))
