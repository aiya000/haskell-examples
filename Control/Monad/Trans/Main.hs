{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Control.Applicative (Alternative)
import Control.Arrow ((>>>))
import Control.Monad (MonadPlus, mzero)
import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.Reader (MonadReader, ReaderT, runReaderT, ask)
import Control.Monad.State.Lazy (MonadState, StateT, runStateT, get, put)
import Control.Monad.Trans.Maybe (MaybeT, runMaybeT)

data MyState = MyState
  { foo :: Int
  } deriving (Show)

initialMyState :: MyState
initialMyState = MyState 10


data MyROM = MyROM
  { bar :: Int
  } deriving (Show)

defaultMyROM = MyROM 20


newtype Mine a = Mine
  { _runMine :: MaybeT (StateT MyState (ReaderT MyROM IO)) a
  } deriving ( Functor, Applicative, Monad
             , Alternative, MonadPlus
             , MonadState MyState
             , MonadReader MyROM
             , MonadIO
             )

runMine :: Mine a -> IO (Maybe a, MyState)
runMine = _runMine
            >>> runMaybeT
            >>> flip runStateT initialMyState
            >>> flip runReaderT defaultMyROM


k :: Mine ()
k = do
  MyState foo' <- get
  MyROM bar'   <- ask
  let result = foo' + bar'
  put $ MyState result
  liftIO $ print result
  mzero -- Mine's mzero is MaybeT's Nothing


main :: IO ()
main = do
  (result, s) <- runMine k
  print s
  print result
--- vvv output vvv
-- 30
-- MyState {foo = 30}
-- Nothing
