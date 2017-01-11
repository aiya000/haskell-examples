import Control.Zipper

-- data Top
-- data Zipper h i a
-- data a :@ i
-- type h :>> a = Zipper h Int a
--
-- zipper :: a -> Top :>> a

main :: IO ()
main = do
  print $ (rezip . zipper) 10
