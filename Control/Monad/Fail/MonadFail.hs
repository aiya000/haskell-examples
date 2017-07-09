{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeSynonymInstances #-}

import Control.Monad (join)
import Control.Monad.Fail (MonadFail(..))
import Control.Monad.Trans.Identity (IdentityT(..), runIdentityT)
import Prelude hiding (fail)

newtype I a = I { runI :: a }

deriving instance Show a => Show (I a)

instance Functor I where
  fmap f (I a) = I $ f a

instance Applicative I where
  pure = I
  (I f) <*> (I a) = I $ f a

instance Monad I where
  (I a) >>= k = k a


newtype Mine a = Mine { runMine :: I (Maybe a) }

deriving instance Show a => Show (Mine a)

instance Functor Mine where
  fmap f (Mine a) = Mine (fmap f <$> a)

instance Applicative Mine where
  pure = Mine . I . Just
  (Mine (I f)) <*> (Mine (I a)) = Mine . I $ f <*> a

instance Monad Mine where
  (Mine (I (Just a))) >>= k = k a
  _ >>= _ = Mine $ I Nothing


instance MonadFail Mine where
  fail _ = Mine $ I Nothing


context :: Mine ()
context = do
  x <- fail "sugar"
  x `seq` return ()


main :: IO ()
main = print context
