import System.Random
import Control.Monad.State

--- Definition
-- instance Monad (State s) where
--  return x = State $ \s -> (x,s)
--  (State h) >>= f = State $ \s -> let (a, newState) = h s
--                                      (State g) = f a
--                                  in  g newState

{- How to do -} -- {{{

type Stack = [Int]

pop :: State Stack Int
pop = state $ \(x:xs) -> (x, xs)

push :: Int -> State Stack ()
push a = state $ \xs -> ((), a:xs)


stackManip :: State Stack Int
stackManip = do
  push 3
  pop
  pop


runningStack = runState stackManip [4,5,6,7]

-- }}}

{- MonadState class -} -- {{{

--- Difined function for State class
-- get = state $ \s -> (s, s)
-- put newState = state $ \s -> ((), newState)

stackManip' :: State Stack Int
stackManip' = do
  push 3
  pop
  pop
  where  push a = do
           stack <- get
           put (a:stack)
         pop = do
           (x:stack) <- get
           put stack
           return x

runningStack' = runState stackManip' [4,5,6,7]

-- }}}

{- Logging State easily -} -- {{{

randBool3rd :: State StdGen (Bool, Bool, Bool)
randBool3rd = do
  a <- newRandBool
  b <- newRandBool
  c <- newRandBool
  return (a,b,c)
  where
    --newRandBool :: (RandomGen g, Random a) -> State g a
    newRandBool = state random

-- runningRandBool = randBool3rd (mkStdGen 11)

-- }}}
