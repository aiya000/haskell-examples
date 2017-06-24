{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}

data Topping = Space -- ^ A space can be inserted some @Topping@
             | Cheese | Tomato | Meet | Ushi

-- dekinai  vvv
--type family AddTopping
--    (h :: Humberger (a :: Topping) (b :: Topping) (c :: Topping) (d :: Topping))
--    (t :: Topping)
--    :: Humberger (a :: Topping) (b :: Topping) (c :: Topping) (d :: Topping) where
type family AddTopping (h :: HumbergerT) (t :: Topping) :: HumbergerT where
  AddTopping (HumbergerC Space b c d) t = HumbergerC t b c d
  AddTopping (HumbergerC a Space c d) t = HumbergerC a t c d
  AddTopping (HumbergerC a b Space d) t = HumbergerC a b t d
  AddTopping (HumbergerC a b c Space) t = HumbergerC a b c t
  AddTopping (HumbergerC _ _ _ _)     _ = Fail
  AddTopping Fail                     _ = Fail

data Humberger (h :: HumbergerT) where
     Refl :: Humberger (HumbergerC a b c d)

data HumbergerT
   = HumbergerC Topping Topping Topping Topping
   | Fail

type BasicHumberger = HumbergerC Space Space Space Space

type Humberger1 = AddTopping BasicHumberger Cheese
type Humberger2 = AddTopping Humberger1 Tomato
type Humberger3 = AddTopping Humberger2 Meet
type Humberger4 = AddTopping Humberger3 Ushi
type Humberger5 = AddTopping Humberger4 Ushi

x1 = Refl :: Humberger Humberger1
x2 = Refl :: Humberger Humberger2
x3 = Refl :: Humberger Humberger3
x4 = Refl :: Humberger Humberger4
-- x5 = Refl :: Humberger Humberger5 -- This is the compile error because Refl is not a Fail's value


main :: IO ()
main = return ()
