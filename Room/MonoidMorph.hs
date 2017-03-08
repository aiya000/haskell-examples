{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE UndecidableInstances #-}

import Prelude hiding (Monoid, sum)

-- モノイドは以下のものを持つ
class Monoid a where
  zero :: a
  (+++)  :: a -> a -> a

-- あるAは法則を満たす
-- x,y,z∈ ==> assoc x y z == True
-- x∈A    ==> ident x     == True
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
confirmSumIsMonoid = putStrLn $ "Sum: " ++ (show $ assoc (Sum 10) (Sum 20) (Sum 30))

-- （CompSumがモノイドであることの確認）
confirmCompSumIsMonoid :: IO ()
confirmCompSumIsMonoid = putStrLn $ "CompSum: " ++ (show $ assoc (CompSum (10+)) (CompSum (20+)) (CompSum (30+)))


-- Sumは以下のようにしてCompSumに変換することができる
endoSumToCompSum :: Sum -> CompSum
endoSumToCompSum (Sum s) = CompSum $ (s+)

-- CompSumは以下のようにしてSumに変換することができる
endoCompSumToSum :: CompSum -> Sum
endoCompSumToSum (CompSum f) = Sum $ f 0

-- （SumからCompSumへ変換できることの確認）
confirmEndoSumToCompSum :: IO ()
confirmEndoSumToCompSum = do
  let result = (CompSum (10+)) == endoSumToCompSum (Sum 10)  -- 10は適当に選ばれた元
  putStrLn $ "Sum -> CompSum: " ++ show result

-- （CompSumからSumへ変換できることの確認）
confirmEndoCompSumToSum :: IO ()
confirmEndoCompSumToSum = do
  let result = (Sum 10) == endoCompSumToSum (CompSum (10+))  -- 10は適当に選ばれた元#
  putStrLn $ "CompSum -> Sum: " ++ show result


-- 確認の実行
main :: IO ()
main = do
  confirmSumIsMonoid
  confirmCompSumIsMonoid
  confirmEndoSumToCompSum
  confirmEndoCompSumToSum
