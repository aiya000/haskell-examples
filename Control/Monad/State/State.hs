import Control.Monad.State (State, runState, get, put, modify, state)

main :: IO ()
main = do
  print $ runState getState  0
  print $ runState getState' 0

getState :: State Int Int
getState = do
  a <- get
  --put $ a + 10
  modify (+10)  -- same as `put $ a + 10`
  return a

getState' :: State Int Int
getState' = state $ \a -> (a, a + 10)
