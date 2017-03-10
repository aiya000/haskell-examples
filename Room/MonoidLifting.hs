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

-- - >8 - --

-- (Int, 1, +)はモノイドである
-- （Sumはモノイドである）
newtype Sum = Sum { unSum :: Int }
  deriving (Eq, Show)
instance Monoid Sum where
  zero = Sum 1
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
confirmSumIsMonoid = quickCheck $ \(x :: Int) (y :: Int) (z :: Int) ->
  assoc (Sum x) (Sum y) (Sum z)

-- （CompSumがモノイドであることの確認）
confirmCompSumIsMonoid :: IO ()
confirmCompSumIsMonoid = quickCheck $ \(x :: Int) (y :: Int) (z :: Int) ->
  assoc (CompSum (x+)) (CompSum (y+)) (CompSum (z+))


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
  putStr "Is Sum is Monoid ?     >> " >> confirmSumIsMonoid
  putStr "Is CompSum is Monoid ? >> " >> confirmCompSumIsMonoid
  putStr "endomorphism of (Sum -> CompSum) >>" >> confirmEndo
  putStr "endomorphism of (CompSum -> Sum) >>" >> confirmEndo'
