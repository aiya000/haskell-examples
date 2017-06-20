{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

data a :=: b where
  Refl :: a :=: b
        deriving (Show)

-- The value level Nat
-- data Nat = Zero | Succ Nat

-- The type level Nat
data Zero
data Succ n
data Nat n where
  Zero :: Nat Zero
  Succ :: Nat n -> Nat (Succ n)

type family (:+:) a b where
  -- Lift Zero, n and (Succ l) to the type level
  Zero :+: n = n
  (Succ n) :+: m = Succ (n :+: m)


-- Proof of a + 0 = a
prop0 :: Nat a -> (a :+: Zero) :=: a
prop0 Zero     = Refl
prop0 (Succ n) = case prop0 n of Refl -> Refl

---- Proof of 0 + a = a + 0 = a
prop1 :: (Zero :+: a) :=: (a :+: Zero) :=: a
prop1 = Refl

main = return ()
