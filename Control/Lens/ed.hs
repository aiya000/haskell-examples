import Control.Lens
import Data.Monoid (Sum(..))


xs :: [Sum Int]
xs = map Sum [1, 2, 3]

main :: IO ()
main = print $ xs ^. folded
