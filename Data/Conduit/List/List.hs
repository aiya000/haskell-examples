-- See http://hackage.haskell.org/package/conduit-1.2.6.4/docs/Data-Conduit-List.html
import Control.Monad.Trans.Resource
import Data.Conduit
import qualified Data.Conduit.List as CL

main :: IO ()
main = do
  foo <- CL.sourceList [1..10] $$ CL.map (+10) =$ CL.consume
  bar <- CL.sourceList [1..10] $$ CL.fold (+) 0
  print foo
  print bar
