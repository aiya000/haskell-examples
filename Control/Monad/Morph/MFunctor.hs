import Control.Monad.Morph
import Control.Monad.Trans.Identity (IdentityT, runIdentityT)
import Control.Monad.Trans.Reader (Reader, reader, runReader)
import Control.Monad.Trans.State (State, runState)

naturalMMorph :: State Int a -> Reader Int a
naturalMMorph st = do
  let nakedSt = runState st
  reader $ fst . nakedSt

-- This will be compiled to the error
-- unnaturalMMorph :: State Int Int -> Reader Int Int
-- unnaturalMMorph st = do
--   let nakedSt = runState st
--   reader $ (+1) . fst . nakedSt


emptyISt :: IdentityT (State Int) Char
emptyISt = return 'a'

main :: IO ()
main = do
  let emptyIR = hoist naturalMMorph emptyISt
  print $ flip runReader 10 $ runIdentityT emptyIR

-- output
-- 'a'
