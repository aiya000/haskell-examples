{-# LANGUAGE DataKinds #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE LiberalTypeSynonyms #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}

--import Data.Singletons.Bool (SBool(..))
import Data.Singletons (Sing, SingI(..))
import Data.Type.Equality (type (==))

-- True,False :: Bool

-- Zero :: Nat
-- n :: Nat ==> Succ n :: Nat
data Nat = Zero | Succ Nat
  deriving (Show)

--NOTE: Why these line needs UndecidableInstances ?
infixl 5 +
type family (n :: Nat) + (m :: Nat) :: Nat where
  Zero   + Zero   = Zero
  Succ n + Zero   = Succ n
  Zero   + Succ m = Succ m
  Succ n + Succ m = Succ (Succ (m + n))

-- t :: Nat ==> IsZero t :: Bool
type family IsZero (t :: Nat) :: Bool where
  IsZero (Succ n) = False
  IsZero n = True

infixl 6 &&
type family (b :: Bool) && (c :: Bool) :: Bool where
  True && True = True
  _    && _    = False

infixl 5 ||
type family (b :: Bool) || (c :: Bool) :: Bool where
  False || False = False
  _     || _     = True


newtype instance Sing (n :: Nat) = SNat Nat
  deriving (Show)

-- Get the value of 'Nat' as 'Int' from the type level world
pullNat :: Sing (n :: Nat) -> Int
pullNat (SNat Zero) = 0
pullNat (SNat (Succ n)) = 1 + pullNat (SNat n)

instance SingI Zero where
  sing :: Sing (n :: Nat)
  sing = SNat Zero

instance SingI n => SingI (Succ n) where
  sing :: Sing (Succ n :: Nat)
  sing = let SNat m = sing :: Sing n
         in SNat $ Succ m

newtype instance Sing (z :: Bool) = SBool Bool

instance SingI True where
  sing :: Sing (b :: Bool)
  sing = SBool True

instance SingI False where
  sing :: Sing (b :: Bool)
  sing = SBool False

pullBool :: Sing (b :: Bool) -> Bool
pullBool (SBool True)  = True
pullBool (SBool False) = False


main :: IO ()
main = do
  print [ pullNat (sing :: Sing Zero)
        , pullNat (sing :: Sing (Succ Zero))
        , pullNat (sing :: Sing (Succ (Succ Zero)))
        , pullNat (sing :: Sing (Zero + Succ Zero))
        , pullNat (sing :: Sing (Succ Zero + Zero))
        ]
  print [ pullBool (sing :: Sing False)
        , pullBool (sing :: Sing True)
        , pullBool (sing :: Sing (IsZero (Succ Zero + Zero)))
        , pullBool (sing :: Sing (True || False))
        , pullBool (sing :: Sing (True && True))
        , pullBool (sing :: Sing (True == True))
        , pullBool (sing :: Sing (True == False))
        ]
-- {output}
-- [0,1,2,1,1]
-- [False,True,False,True,True,True,False]
