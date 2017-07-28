import Data.Char (ord)
import Data.Function ((&))
import Data.Profunctor

x :: Either Char ()
x = Left 'a'

y :: Either () Char
y = Right 'a'

main :: IO ()
main = do
  print $ x & left' ord
  print $ y & right' ord
