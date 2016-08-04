-- If you want to see Control.Monad.Catch with IO,
-- Please see /Control/Monad/Trans/Either/EitherT.hs
import Control.Exception (ArithException (..))
import Control.Monad.Catch

main :: IO ()
main = do
  -- ten is alternative value
  let Right x = 10 `safeDiv` 0 `catch` ten
  print x
    where
      ten :: SomeException -> Either SomeException Int
      ten _ = return 10

safeDiv :: MonadCatch m => Int -> Int -> m Int
safeDiv x y =
  if y == 0
     then throwM RatioZeroDenominator
     else return $ x `div` y
