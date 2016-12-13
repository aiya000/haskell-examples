{-# LANGUAGE GADTs #-}

data Zero
data Succ n

infixr 9 :-
data Vector a n where
  Nil :: Vector a Zero
  (:-) :: a -> Vector a n -> Vector a (Succ n)


neoTail :: Vector a (Succ n) -> Vector a n
neoTail (_ :- xs) = xs

neoHead :: Vector a (Succ n) -> a
neoHead (x :- _) = x

main :: IO ()
main = do
  let xs = 1 :- 2 :- 3 :- Nil
      ys = neoTail xs
      -- To be compile error
      --zs = neoTail . neoTail . neoTail . neoTail $ xs
      x  = neoHead xs
      y  = neoHead . neoTail $ xs
  print x
  print y
