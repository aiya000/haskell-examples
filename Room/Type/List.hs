data List a = Nil | Cons a (List a) deriving Show

emp = Nil :: List Int
uni = Cons 10 Nil
xx  = Cons 10 (Cons 20 Nil)

fromGeneral :: [a] -> List a
fromGeneral []     = Nil
fromGeneral (x:xs) = x `Cons` fromGeneral xs

xxx = fromGeneral [1,2,3]

main :: IO ()
main = do
  print emp
  print uni
  print xx
  print xxx
