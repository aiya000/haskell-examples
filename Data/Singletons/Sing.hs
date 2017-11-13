{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Proxy (Proxy(..))
import Data.Singletons (SingI(..), Sing)
import GHC.TypeLits (KnownNat, Nat, natVal, KnownSymbol, Symbol, symbolVal)

data FooK = BarT Nat
          | BazT Symbol

--data Foo = Bar Int
--         | Baz String
--  deriving (Show)

newtype instance Sing (BarT n) = Bar Integer
newtype instance Sing (BazT s) = Baz String

instance KnownNat n => SingI (BarT n) where
  sing = Bar $ natVal (Proxy :: Proxy n)

instance KnownSymbol s => SingI (BazT s) where
  sing = Baz $ symbolVal (Proxy :: Proxy s)

main :: IO ()
main = do
  let Bar x = sing :: Sing (BarT 10)
      Baz y = sing :: Sing (BazT "sugar")
  print x
  putStrLn y
-- 10
-- sugar
