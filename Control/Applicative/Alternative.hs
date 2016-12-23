import Control.Applicative (Applicative(..), Alternative(..))
import Data.Foldable (asum)

data EmptyOr a = Empty | Elem a deriving (Show)

instance Functor EmptyOr where
  fmap f (Elem x) = Elem $ f x
  fmap _ Empty = Empty

instance Applicative EmptyOr where
  pure = Elem
  Elem f <*> Elem x = Elem $ f x
  Empty <*> Elem _  = Empty
  Elem f <*> Empty = Empty

instance Alternative EmptyOr where
  empty = Empty
  Elem x <|> Elem _ = Elem x
  Elem x <|> Empty  = Elem x
  Empty  <|> Elem y = Elem y
  Empty  <|> Empty  = Empty


main :: IO ()
main = do
  print $ asum . map Elem $ [1,2,3,4,5]
