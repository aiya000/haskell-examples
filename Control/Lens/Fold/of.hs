import Control.Lens

xs :: [Either () Int]
xs = [Right 10, Left (), Right 20]


main :: IO ()
main = do
  print $ sumOf (folded . _Right) xs
  print $ sumOf (folded . _Right) []
