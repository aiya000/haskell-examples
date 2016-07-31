{-# LANGUAGE GADTs #-}

data Item a where
  Lit    :: a -> Item a
  Add    :: Item Int -> Item Int -> Item Int
  IsZero :: Item Int -> Item Bool

eval :: Item a -> a
eval (Lit x)    = x
eval (Add x y)  = eval x + eval y
eval (IsZero x) = (eval x) == 0

main :: IO ()
main = do
  let one = Lit 1
  let two = Add one (Lit 1)
  let b1  = IsZero two
  let b2  = IsZero $ Add two (Lit (-2))
  print $ eval one
  print $ eval two
  print $ eval b1
  print $ eval b2
