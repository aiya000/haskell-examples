import Control.Monad.Free (Free(..))
import Control.Monad.Identity (Identity(..), runIdentity)

type Mine = Free Identity

x :: Mine Int
x = return 10


main :: IO ()
main = do
  let x' = (+1) <$> x
  print x'
