import Data.List (unfoldr)

main :: IO ()
main = do
  let xs = unfoldr unfolder defValue
      ys = foldr folder unit xs
      zs = unfoldr unfolder ys
  print xs
  print ys
  print zs

type Elem = Int

defValue :: Elem
defValue = 10

unit :: Elem
unit = 0

unfolder :: Elem -> Maybe (Elem, Elem)
unfolder x = if x == 0 then Nothing else Just (x, x - 1)

folder :: Elem -> Elem -> Elem
folder x y = x + y
