import Control.Lens

xs :: [Either () Int]
xs = [Right 10, Left (), Right 20]

ys :: [(String, (Int, Char))]
ys = [ ("x", (1, 'x'))
     , ("y", (2, 'y'))
     , ("z", (3, 'z'))
     ]


main :: IO ()
main = do
  print $ sumOf (folded . _Right) xs
  print $ sumOf (folded . _Right) []
  print $ lookupOf (folded . _2) 2 ys
  print $ lookupOf (folded) "z" ys
-- {output}
-- 30
-- 0
-- Just 'y'
-- Just (3,'z')
