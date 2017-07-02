import Control.Monad (void)
import Control.Monad.Trans.State.Lazy (StateT, runStateT)


main :: IO ()
main = void $ runStateT context ()


-- | @StateT () IO@'s failure is transmitted to @IO ()@ (main)
context :: StateT () IO ()
context = fail "failure in context"
