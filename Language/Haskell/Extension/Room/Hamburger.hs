{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Hamberger where

import Hamburger.TH (defineInstances)

-- | A kind of the topping, and types.
data Topping = Space -- ^ Mean a space, it can be inserted some @Topping@
             | Cheese | Tomato | Meet | Ushi

-- |
-- A type level function
-- that maps @HamburgerT@ and @Topping@ to @HamburgerT@.
--
-- If @HamburgerC a b c d@ :: @HamburgerT@ of the domain has no space, or @Fail@ is specified to the domain,
-- return @Fail@ type.
type family AddTopping (h :: HamburgerT) (t :: Topping) :: HamburgerT where
  AddTopping (HamburgerC Space b c d) t = HamburgerC t b c d
  AddTopping (HamburgerC a Space c d) t = HamburgerC a t c d
  AddTopping (HamburgerC a b Space d) t = HamburgerC a b t d
  AddTopping (HamburgerC a b c Space) t = HamburgerC a b c t
  AddTopping _ _ = Fail

-- | A kind of the abstract hamburger
data HamburgerT = HamburgerC Topping Topping Topping Topping -- ^ A type constructor of the abstract hamburger
                | Fail -- ^ Mean a fail of a mapping of @AddTopping@


{- The dependent type -}

-- |
-- A concrete of the hamburger
-- (A type constructor for a type of @HamburgerT@ kind).
data SHamburger (h :: HamburgerT) where
  Concrete :: STopping -> STopping -> STopping -> STopping -> SHamburger (HamburgerC a b c d :: HamburgerT)

-- | A singleton type for @Topping@ kind.
data STopping = SSpace | SCheese | STomato | SMeet | SUshi
  deriving (Show)

-- | Represent the simply dependent type
class Singleton (h :: HamburgerT) where
  sing :: SHamburger h


-- Define any instances for 126 patterns !
defineInstances


type BasicHamburgerC = HamburgerC Space Space Space Space

type HamburgerC1 = AddTopping BasicHamburgerC Cheese -- these kind is @HamburgerT@
type HamburgerC2 = AddTopping HamburgerC1 Tomato
type HamburgerC3 = AddTopping HamburgerC2 Meet
type HamburgerC4 = AddTopping HamburgerC3 Ushi
type HamburgerC5 = AddTopping HamburgerC4 Ushi -- = Fail

x0 = sing :: SHamburger BasicHamburgerC
x1 = sing :: SHamburger HamburgerC1
x2 = sing :: SHamburger HamburgerC2
x3 = sing :: SHamburger HamburgerC3
x4 = sing :: SHamburger HamburgerC4
--x5 = sing :: SHamburger HamburgerC5 -- This is the compile error because Refl is not a Fail's value


main :: IO ()
main = do
  print x0
  print x1
  print x2
  print x3
  print x4
-- vvv output vvv
-- SHamburger (Space Space Space Space)
-- SHamburger (Cheese Space Space Space)
-- SHamburger (Cheese Tomato Space Space)
-- SHamburger (Cheese Tomato Meet Space)
-- SHamburger (Cheese Tomato Meet Ushi)
