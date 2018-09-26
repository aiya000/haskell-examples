{-# LANGUAGE ConstrainedClassMethods #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeSynonymInstances #-}

import Data.Ratio (Rational, (%), denominator, numerator)
import Prelude hiding ((<*>))
import Test.SmallCheck (smallCheck)
import Test.SmallCheck.Series (Serial(..), Series)

newtype NonZeroRational = NonZeroRational
  { unNonZeroRational :: Rational
  } deriving (Show, Eq, Num)

instance Monad m => Serial m NonZeroRational where
  -- | Excludes the zero element from 'Rational'
  series = do
    x <- NonZeroRational <$> series
    pure $
      if x == NonZeroRational (0%1)
         then NonZeroRational (1%1) -- 1%1 is an example of the opportune element
         else x

class Group a where
  (<>) :: a -> a -> a
  empty :: a
  inverse :: a -> a

-- | `'NonZeroGroup' a` must satisfy 'inverseLawForMulti'
class Field a where
  data NonZeroGroup a :: *
  (<+>) :: a -> a -> a
  emptyA :: a
  inverseA :: a -> a
  (<*>) :: Group (NonZeroGroup a) => NonZeroGroup a -> NonZeroGroup a -> NonZeroGroup a
  emptyM :: Group (NonZeroGroup a) => NonZeroGroup a
  inverseM :: Group (NonZeroGroup a) => NonZeroGroup a -> NonZeroGroup a
  infixl 6 <+>
  infixl 7 <*>

instance Group NonZeroRational where
  (<>) = (+)
  empty = NonZeroRational $ 1%1
  inverse (NonZeroRational x) = NonZeroRational $ denominator x % numerator x

instance Field Rational where
  newtype NonZeroGroup Rational = NonZeroRationalGroup NonZeroRational
    deriving (Eq, Show, Group)
  (<+>) = (+)
  emptyA = 0%1
  inverseA = negate

  NonZeroRationalGroup x <*> NonZeroRationalGroup y =
    NonZeroRationalGroup $ x * y

  emptyM = NonZeroRationalGroup . NonZeroRational $ 1%1

  inverseM (NonZeroRationalGroup (NonZeroRational x)) =
    NonZeroRationalGroup . NonZeroRational $ denominator x % numerator x

instance Monad m => Serial m (NonZeroGroup Rational) where
  series = NonZeroRationalGroup <$> series

inverseLawForMulti :: (Field a, Eq (NonZeroGroup a), Group (NonZeroGroup a)) => NonZeroGroup a -> Bool
inverseLawForMulti x = x <*> inverseM x == emptyM

main :: IO ()
main = smallCheck 5 $ inverseLawForMulti @Rational
