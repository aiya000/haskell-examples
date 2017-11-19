{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Void (Void)

-- open type families
type family F (x :: *) :: *
type instance F Int = Void

type FX = F Int -- Void
type FY = F Char -- FY
-- ^ (🤔!?)

-- can be added declarations
type instance F Bool = Void
type FZ = F Bool -- Void


-- closed type families
type family G (x :: *) :: * where
  G Int  = Void
  G Char = Void

type GX = G Int -- Void
type GY = G Char -- Void

-- cannot be added declarations
-- type instance G Bool = Void
-- ~~ error:
--    - Illegal instance for closed family 'G'
--    - In the type instance declaration for 'G'

type GZ = G Bool -- GZ
-- ^ (🤔!?)

-- open data families
data family F' (x :: *)
data instance F' Int = FInt

type F'X = F' Int

f'x :: F'X
f'x = FInt


data family G' (x :: k)

-- A closed data families for a kind
data instance G' (x :: *) where
  G'Int  :: G' Int
  G'Char :: () -> G' Char

data Foo = Bar | Baz

data instance G' (x :: Foo) where
  G'Bar :: G' 'Bar
  G'Baz :: () -> G' 'Baz

g'x :: G' Int
g'x = G'Int

g'y :: G' Char
g'y = G'Char ()

g'bar :: G' 'Bar
g'bar = G'Bar

g'baz :: (G' 'Baz :: *)
g'baz = G'Baz ()


main :: IO ()
main = return ()
