{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}

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

-- |
-- A concrete of the hamburger
-- (A type constructor for a type of @HamburgerT@ kind).
data Hamburger (h :: HamburgerT) where
  Refl :: Hamburger (HamburgerC a b c d)

-- | A kind of the abstract hamburger
data HamburgerT = HamburgerC Topping Topping Topping Topping -- ^ A type constructor of the abstract hamburger
                | Fail -- ^ Mean a fail of a mapping of @AddTopping@


type BasicHamburgerC = HamburgerC Space Space Space Space

type HamburgerC1 = AddTopping BasicHamburgerC Cheese -- these kind is @HamburgerT@
type HamburgerC2 = AddTopping HamburgerC1 Tomato
type HamburgerC3 = AddTopping HamburgerC2 Meet
type HamburgerC4 = AddTopping HamburgerC3 Ushi
type HamburgerC5 = AddTopping HamburgerC4 Ushi -- = Fail

x1 = Refl :: Hamburger HamburgerC1
x2 = Refl :: Hamburger HamburgerC2
x3 = Refl :: Hamburger HamburgerC3
x4 = Refl :: Hamburger HamburgerC4
--x5 = Refl :: Hamburger HamburgerC5 -- This is the compile error because Refl is not a Fail's value


main :: IO ()
main = return ()
