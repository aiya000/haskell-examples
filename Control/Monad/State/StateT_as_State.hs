-- refer http://qiita.com/7shi/items/4408b76624067c17e933

-- data StateT s m a
-- type State s a =  StateT s Identity a

import Control.Monad.Identity
import Control.Monad.State


-- difference StateT and State 1 {{{

sA  = return 10 :: StateT s Identity Int
sA' = return 10 :: State s Int

areEquals1 :: IO Bool
areEquals1 = do
  let a  = evalState sA  ()
      a' = evalState sA' ()
  return $ a == a'

-- }}}

-- difference StateT and State 1 {{{

rA  :: s -> (Int, s)
rA  = runState sA'
rA' :: s -> Identity (Int, s)
rA' = runStateT sA'

areEquals2 :: Bool
areEquals2 = (rA ()) == (runIdentity $ rA' ())

-- }}}

-- StateT functions {{{

stateTFuncs :: IO ()
stateTFuncs = do
  let st = return 20 :: StateT s Identity Int
  print . runIdentity $  runStateT st ()
  print . runIdentity $ evalStateT st ()
  print . runIdentity $ execStateT st ()

-- }}}


main = do
  x <- areEquals1
  print x
  let y = areEquals2
  print y
  stateTFuncs
