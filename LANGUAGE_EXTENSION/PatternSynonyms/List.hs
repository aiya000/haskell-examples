{-# LANGUAGE PatternSynonyms #-}

-- See http://maoe.hatenadiary.jp/entry/2014/03/30/004049

import Control.Monad.Free

-- data Free f a = Pure a | Free (f (Free f a))

data F a b = F a b
  deriving (Show)

instance Functor (F a) where
  fmap f (F a b) = F a (f b)

type List a = Free (F a) ()
pattern Nil = Pure ()
pattern Cons x xs = Free (F x xs)


head' :: List a -> Maybe a
head' Nil = Nothing
head' (Cons x _) = Just x

main :: IO ()
main = do
  let xs = Cons 1 (Cons 2 (Cons 3 Nil))
  print xs
  print $ head' (Nil :: List Int)
  print $ head' xs
