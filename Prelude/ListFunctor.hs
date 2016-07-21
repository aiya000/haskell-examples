data List a = Cons a (List a) | Nil
            deriving Show


xs :: List Int
xs = Cons 1 (Cons 2 (Cons 3 Nil))

instance Functor List where
  fmap f Nil         = Nil
  fmap f (Cons x xs) = Cons (f x) (fmap f xs)
