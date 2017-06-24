{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}

-- | A kind of the topping, and types.
data Topping = Space -- ^ Mean a space, it can be inserted some @Topping@
             | Cheese | Tomato | Meet | Ushi

-- |
-- A type level function
-- that maps @HumbergerT@ and @Topping@ to @HumbergerT@.
--
-- If @HumbergerC a b c d@ :: @HumbergerT@ of the domain has no space, or @Fail@ is specified to the domain,
-- return @Fail@ type.
type family AddTopping (h :: HumbergerT) (t :: Topping) :: HumbergerT where
  AddTopping (HumbergerC Space b c d) t = HumbergerC t b c d
  AddTopping (HumbergerC a Space c d) t = HumbergerC a t c d
  AddTopping (HumbergerC a b Space d) t = HumbergerC a b t d
  AddTopping (HumbergerC a b c Space) t = HumbergerC a b c t
  AddTopping _ _ = Fail

-- |
-- A concrete of the humberger
-- (A type constructor for a type of @HumbergerT@ kind).
data Humberger (h :: HumbergerT) where
  Refl :: Humberger (HumbergerC a b c d)

-- | A kind of the abstract humberger
data HumbergerT = HumbergerC Topping Topping Topping Topping -- ^ A type of the abstract humberger
                | Fail -- ^ Mean a fail of a mapping of @AddTopping@


type BasicHumbergerC = HumbergerC Space Space Space Space

type HumbergerC1 = AddTopping BasicHumbergerC Cheese -- these kind is @HumbergerT@
type HumbergerC2 = AddTopping HumbergerC1 Tomato
type HumbergerC3 = AddTopping HumbergerC2 Meet
type HumbergerC4 = AddTopping HumbergerC3 Ushi
type HumbergerC5 = AddTopping HumbergerC4 Ushi -- = Fail

x1 = Refl :: Humberger HumbergerC1
x2 = Refl :: Humberger HumbergerC2
x3 = Refl :: Humberger HumbergerC3
x4 = Refl :: Humberger HumbergerC4
--x5 = Refl :: Humberger HumbergerC5 -- This is the compile error because Refl is not a Fail's value


main :: IO ()
main = return ()
