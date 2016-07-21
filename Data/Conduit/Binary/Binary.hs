import Control.Monad.Trans.Resource
import Data.Conduit
import qualified Data.Conduit.Binary as CB

main :: IO ()
main = runResourceT $ CB.sourceFile "copyFrom.txt" $$ CB.sinkFile "copyTo.txt"
