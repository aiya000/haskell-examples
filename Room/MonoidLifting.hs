{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE UndecidableInstances #-}

import Prelude hiding (Monoid, sum)
import Test.QuickCheck (quickCheck)

-- モノイドは以下のものを持つ
class Monoid a where
  zero :: a
  (+++)  :: a -> a -> a

-- あるAは法則を満たす
-- ∀x,y,z∈A      ==> (x +++ y) +++ z = x +++ (y +++ z)
-- ∃zero∈A, x∈A ==> zero +++ x = zero = x +++ zero
class MonoidLaw a where
  assoc :: a -> a -> a -> Bool
  default assoc :: (Eq a, Monoid a) => a -> a -> a -> Bool
  assoc x y z = (x +++ y) +++ z == x +++ (y +++ z)
  ident :: a -> Bool
  default ident :: (Eq a, Monoid a) => a -> Bool
  ident x = (zero +++ x == x) && (x == x +++ zero)

-- モノイドはAである
instance (Eq a, Monoid a) => MonoidLaw a

data AlwaysTrue = AlwaysTrue
-- To be compile error
--instance MonoidLaw AlwaysTrue
-- If AlwaysTrue isn't Eq instance, you must implement MonoidLaw instance yourself
instance MonoidLaw AlwaysTrue where
  assoc _ _ _ = True
  ident _ = True

-- - >8 - --

-- (Int, 1, +)はモノイドである
-- （Sumはモノイドである）
newtype Sum = Sum { unSum :: Int }
  deriving (Eq, Show)
instance Monoid Sum where
  zero = Sum 0
  (Sum x) +++ (Sum y) = Sum $ x + y

-- (Int -> Int, (0+), .)はモノイドである
-- （CompSumはモノイドである）
newtype CompSum = CompSum { unCompSum :: Int -> Int }
instance Monoid CompSum where
  zero = CompSum (0+)
  (CompSum g) +++ (CompSum f) = CompSum $ g . f
instance Eq CompSum where
  (CompSum f) == (CompSum g) = (f 0) == (g 0)

-- （Sumがモノイドであることの確認）
confirmSumIsMonoid :: IO ()
confirmSumIsMonoid = do
  quickCheck $ \(x :: Int) (y :: Int) (z :: Int) ->
    assoc (Sum x) (Sum y) (Sum z)
  quickCheck $ \(x :: Int) ->
    ident (Sum x)

-- （CompSumがモノイドであることの確認）
confirmCompSumIsMonoid :: IO ()
confirmCompSumIsMonoid = do
  quickCheck $ \(x :: Int) (y :: Int) (z :: Int) ->
    assoc (CompSum (x+)) (CompSum (y+)) (CompSum (z+))
  quickCheck $ \(x :: Int) ->
    ident (CompSum (x+))


-- Sumは以下のようにしてCompSumに変換することができる
endo :: Sum -> CompSum
endo (Sum s) = CompSum $ (s+)

-- CompSumは以下のようにしてSumに変換することができる
endo' :: CompSum -> Sum
endo' (CompSum f) = Sum $ f 0

-- （SumからCompSumへ変換できることの確認）
confirmEndo :: IO ()
confirmEndo = quickCheck $ \(x :: Int) ->
  (CompSum (x+)) == endo (Sum x)

-- （CompSumからSumへ変換できることの確認）
confirmEndo' :: IO ()
confirmEndo' = quickCheck $ \(x :: Int) ->
  (Sum x) == endo' (CompSum (x+))


-- 確認の実行
main :: IO ()
main = do
  putStrLn "Is Sum is Monoid ?"
  confirmSumIsMonoid
  putStrLn ""

  putStrLn "Is CompSum is Monoid ?"
  confirmCompSumIsMonoid
  putStrLn ""

  putStrLn "endomorphism of (Sum -> CompSum)"
  confirmEndo
  putStrLn ""

  putStrLn "endomorphism of (CompSum -> Sum)"
  confirmEndo'
