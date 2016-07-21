-- See http://hackage.haskell.org/package/containers-0.5.7.1/docs/Data-Set.html
import Data.Set ( Set, (\\) )
import qualified Data.Set as Set

xs :: Set Int
xs = Set.fromList [1, 2, 3, 4, 6, 7, 8, 9, 10]

ys :: Set Int
ys = Set.fromList [5..15]

zs :: Set Int
zs = Set.fromList [11..20]

xs' :: Set Int
xs' = Set.singleton 1

ys' :: Set Int
ys' = Set.empty

main :: IO ()
main = do
  print $ xs \\ ys
  print $ xs `Set.difference` ys
  print $ Set.member 5 xs
  print $ xs'
  print $ ys'
  print $ Set.insert 5  xs
  print $ Set.delete 10 xs
  print $ xs `Set.union` ys
