lshift :: ([a], a) -> a -> ([a], a)
lshift (xs, x) y = (x:xs, y)

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' (+^+) init xs =
  let xs' = map (+^+) xs
      f   = foldl (.) id xs'
  in f init

-- foldr (flip lshift) ([0], 1) [2..5]
-- ([1,0], 5) [2..4]
-- ([5,1,0], 4) [2,3]
-- ([4,5,1,0], 3) [2]
-- ([3,4,5,1,0], 2) []
-- ([3,4,5,1,0], 2)
main :: IO ()
main = do
  print $ foldl lshift ([0], 1) [2..5]
  print $ foldr (flip lshift) ([0], 1) [2..5]
  print $ foldr' (flip lshift) ([0], 1) [2..5]
