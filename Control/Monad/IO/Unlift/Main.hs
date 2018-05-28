import Control.Monad.IO.Unlift
import RIO (RIO, liftIO)

-- unliftio is useful in a case like below.

context :: RIO a ()
context = pure ()

requireIO :: IO a -> IO a
requireIO = id

anotherMain :: RIO a ()
anotherMain = do
  -- We want to use `context` in `requireIO`,
  -- but a type of `context` is not `IO`.
  context' <- toIO context
  result   <- liftIO $ requireIO context'
  pure ()

main :: IO ()
main = pure ()
