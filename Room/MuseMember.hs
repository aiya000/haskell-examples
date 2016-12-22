import Data.Monoid

data Muse = HanayoKoizumi | RinHoshizora | MakiNishikino
          | UmiSonoda     | KotoriMinami | HonokaKosaka
          | EliAyase      | NicoYazawa   | NozomiTojo
          deriving (Eq, Ord, Enum, Show)

next :: Muse -> Muse
next HanayoKoizumi = RinHoshizora
next RinHoshizora  = MakiNishikino
next MakiNishikino = UmiSonoda
next UmiSonoda     = KotoriMinami
next KotoriMinami  = HonokaKosaka
next HonokaKosaka  = EliAyase
next EliAyase      = NicoYazawa
next NicoYazawa    = NozomiTojo
next NozomiTojo    = HanayoKoizumi

prev :: Muse -> Muse
prev HanayoKoizumi = NozomiTojo
prev RinHoshizora  = HanayoKoizumi
prev MakiNishikino = RinHoshizora
prev UmiSonoda     = MakiNishikino
prev KotoriMinami  = UmiSonoda
prev HonokaKosaka  = KotoriMinami
prev EliAyase      = HonokaKosaka
prev NicoYazawa    = EliAyase
prev NozomiTojo    = NicoYazawa

musePlus :: Muse -> Muse -> Muse
HanayoKoizumi `musePlus` HanayoKoizumi = HanayoKoizumi
HanayoKoizumi `musePlus` y             = let y' = prev y
                                         in next $ HanayoKoizumi `musePlus` y'
x `musePlus` y                         = let x' = prev x
                                         in next $ x' `musePlus` y

instance Monoid Muse where
  mempty  = HanayoKoizumi
  mappend = musePlus

areSatisfyMonoidLaw :: Muse -> Muse -> Muse -> Bool
areSatisfyMonoidLaw x y z =
  let isAssociative = (x <> y) <> z == x <> (y <> z)
      unitExists    = mempty <> x == x && x == x <> mempty
  in isAssociative && unitExists

museIsMonoid :: Bool
museIsMonoid = foldr (&&) True $ do
  x <- [HanayoKoizumi .. NozomiTojo]
  y <- [HanayoKoizumi .. NozomiTojo]
  z <- [HanayoKoizumi .. NozomiTojo]
  return $ areSatisfyMonoidLaw x y z

class Group a where
  gempty :: a
  (<++>) :: a -> a -> a  -- 群の二項演算子
  ginv   :: a -> a       -- 元から逆元を取る関数

instance Group Muse where
  gempty = mempty
  (<++>) = (<>)
  ginv i = foldr1 (.) (replicate 3 next) $ i

areSatisfyGroupLaw :: Muse -> Muse -> Muse -> Bool
areSatisfyGroupLaw x y z = --areSatisfyMonoidLaw x y z &&
  x <++> (ginv x) == gempty && gempty == (ginv x) <++> x

museIsGroup :: Bool
museIsGroup = foldr (&&) True $ do
  x <- [HanayoKoizumi .. NozomiTojo]
  y <- [HanayoKoizumi .. NozomiTojo]
  z <- [HanayoKoizumi .. NozomiTojo]
  return $ areSatisfyGroupLaw x y z
