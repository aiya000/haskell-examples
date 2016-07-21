
main :: IO ()
main = do
  print sumOfPowers
  print $ replicate' 3 True
  print $ pyths 10
  print $ perfects 500
  print funnyGenerate


sumOfPowers = sum [x^2 | x <- [1..100]]

replicate' n x = [x | _ <- [1..n]]

pyths n = [(x,y,z) | x <- [2..n], y <- [2..n], z <- [2..n], x^2 + y^2 == z^2]

perfects n = [x | x <- [1..n], sum (factors x) == x]
  where factors m = [y | y <- [1..m-1], m `mod` y == 0]

funnyGenerate = concat [halfZip x [1,2,3] | x <- [1,2,3]]
  where halfZip a xs = zip (repeat a) xs
