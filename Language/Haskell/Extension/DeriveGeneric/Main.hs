{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}

import Data.Bits ((.&.), shiftR)
import Data.Char (ord)
import Data.Semigroup ((<>))
import GHC.Generics

data Sugar = Sugar
  { sweet :: String
  , moon :: Int
  } deriving (Generic, Show)

instance Serialize Sugar

sugar :: Sugar
sugar = Sugar "me" 1000

data Bit = I | O
  deriving (Show)

iso :: Bool -> Bit
iso True  = I
iso False = O

class Serialize a where
  put :: a -> [Bit]
  default put :: (Generic a, GSerialize (Rep a)) => a -> [Bit]
  put = gput . from

instance Serialize Int where
  put 0 = [O]
  put x = reverse $ f x
    where
      f :: Int -> [Bit]
      f x | x > 0 = let bit  = iso . isZero $ x .&. 0x0001
                        rest = x `shiftR` 1
                    in bit : f rest
          | otherwise = []

      isZero :: Int -> Bool
      isZero 0 = True
      isZero _ = False

instance Serialize Char where
  put = put . ord

instance Serialize a => Serialize [a] where
  put [] = []
  put (x:xs) = put x <> put xs

class GSerialize f where
  gput :: f a -> [Bit]

instance (GSerialize f, GSerialize g) => GSerialize (f :+: g) where
  gput (L1 x) = I : gput x
  gput (R1 x) = O : gput x

instance (GSerialize f, GSerialize g) => GSerialize (f :*: g) where
  gput (x :*: y) = gput x <> gput y

instance GSerialize f => GSerialize (M1 i c f) where
  gput (M1 x) = gput x

instance Serialize a => GSerialize (K1 i a) where
  gput (K1 x) = put x

main :: IO ()
main = print $ put sugar
