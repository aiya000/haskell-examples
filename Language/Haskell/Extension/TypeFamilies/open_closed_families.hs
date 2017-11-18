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
