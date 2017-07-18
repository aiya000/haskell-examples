{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

import Data.Void (Void)


type X = '[True, False]

-- >>> :kind! X
--
-- X :: [Bool]
-- = X

type Y = '[Int]
-- Y :: [*]

type Z = '(Int, Int)


-- | Add a type and a type
data a :+: b = Refl

type family Sum (a :: [*]) :: * where
  Sum '[] = Void
  Sum (x:xs) = x :+: Sum xs

type A = Sum '[Int, Bool, Char]
