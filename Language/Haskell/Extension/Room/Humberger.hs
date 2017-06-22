{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}

data Fail

data Topping = Space -- ^ A space can be inserted some @Topping@
             | Cheese | Tomato | Meet | Ushi

-- dekinai  vvv
--type family AddTopping
--    (h :: Humberger (a :: Topping) (b :: Topping) (c :: Topping) (d :: Topping))
--    (t :: Topping)
--    :: Humberger (a :: Topping) (b :: Topping) (c :: Topping) (d :: Topping) where
type family AddTopping (h :: k) (t :: Topping) :: k where
  AddTopping (Humberger Space b c d) t = Humberger t b c d
  AddTopping (Humberger a Space c d) t = Humberger a t c d
  AddTopping (Humberger a b Space d) t = Humberger a b t d
  AddTopping (Humberger a b c Space) t = Humberger a b c t
  AddTopping _ _ = Fail

data Humberger (a :: Topping) (b :: Topping) (c :: Topping) (d :: Topping)
   = Refl

type BasicHumberger = Humberger Space Space Space Space

type Humberger1 = AddTopping BasicHumberger Cheese
type Humberger2 = AddTopping Humberger1 Tomato
type Humberger3 = AddTopping Humberger2 Meet
type Humberger4 = AddTopping Humberger3 Ushi
type Humberger5 = AddTopping Humberger4 Ushi -- = Fail

x1 = Refl :: Humberger1
x2 = Refl :: Humberger2
x3 = Refl :: Humberger3
x4 = Refl :: Humberger4
--x5 = Refl :: Humberger5 -- This is the compile error because Refl is not a Fail's value


main :: IO ()
main = return ()
