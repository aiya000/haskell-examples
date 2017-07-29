import Data.Monoid ((<>), First(..))

-- First return the leftmost value, but Nothing is always skipped

x :: First Int
x = First $ Just 10

y :: First Int
y = First $ Just 20

z :: First Int
z = First Nothing

z' :: First Int
z' = First Nothing

main :: IO ()
main = do
  print $ x <> y
  print $ y <> x
  print $ x <> z
  print $ z <> x
  print z
  print $ z <> z'
--First {getFirst = Just 10}
--First {getFirst = Just 20}
--First {getFirst = Just 10}
--First {getFirst = Just 10}
--First {getFirst = Nothing}
--First {getFirst = Nothing}
