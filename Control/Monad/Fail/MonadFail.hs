{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}

import Control.Monad (join)
import Control.Monad.Fail (MonadFail(..))
import Control.Monad.Trans.Identity (IdentityT(..), runIdentityT)
import Prelude hiding (fail)
import Control.Exception.Safe (catch, SomeException)

newtype I a = I { runI :: a }

deriving instance Show a => Show (I a)

instance Functor I where
  fmap f (I a) = I $ f a

instance Applicative I where
  pure = I
  (I f) <*> (I a) = I $ f a

instance Monad I where
  (I a) >>= k = k a


data Mine a = Mine { runMine :: I (Maybe a) }
            | Yours -- a failure

deriving instance Show a => Show (Mine a)

instance Functor Mine where
  fmap f (Mine a) = Mine (fmap f <$> a)
  fmap _ Yours    = Yours

instance Applicative Mine where
  pure = Mine . I . Just
  (Mine (I f)) <*> (Mine (I a)) = Mine . I $ f <*> a
  _ <*> _ = Yours

instance Monad Mine where
  (Mine (I (Just a))) >>= k = k a
  _ >>= _ = Yours


instance MonadFail Mine where
  fail _ = Yours


context :: Mine ()
context = do
  x <- fail "sugar"
  x `seq` return ()

context' :: Mine ()
context' = do
  x <- Mine $ I (Nothing :: Maybe ())
  x `seq` return ()

context'' :: Mine ()
context'' = do
  x <- Yours
  x `seq` return ()

context''' :: Mine ()
context''' = do
  I x <- Yours
  x `seq` return ()

badContext :: Mine ()
badContext = do
  Left x <- return (Right 10 :: Either Int Int)
  x `seq` return ()


main :: IO ()
main = do
  print context
  print context'
  print context''
  print context'''
  -- This cannot be caught in the pure context,
  -- because Mine's value constructors are not used in that pattern match
  print badContext `catch` \e -> print (e :: SomeException)
