import Data.Bifunctor (bimap, first, second)

main :: IO ()
main = do
  print $ bimap  (*2) (*3) (1,2)
  print $ first  (*2) (1,2)
  print $ second (*2) (1,2)
