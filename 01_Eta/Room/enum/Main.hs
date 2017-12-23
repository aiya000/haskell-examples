{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE TypeFamilies #-}

import Java
import Prelude hiding (Enum)
import Java.Utils (Enum)

data {-# CLASS "java.lang.Thread.State" #-} ThreadState =
  ThreadState (Object# ThreadState)
  deriving (Class)

type instance Inherits ThreadState = '[Enum ThreadState]

foreign import java unsafe "@static @field java.lang.Thread.State.BLOCKED" threadBlocked :: ThreadState
foreign import java unsafe "@static @field java.lang.Thread.State.NEW" threadNew :: threadState
foreign import java unsafe "@static @field java.lang.Thread.State.RUNNABLE" threadRunnable :: ThreadState
foreign import java unsafe "@static @field java.lang.Thread.State.TERMINATED" threadTerminated :: ThreadState
foreign import java unsafe "@static @field java.lang.Thread.State.TIMED_WAITING" threadTimedWaiting :: ThreadState
foreign import java unsafe "@static @field java.lang.Thread.State.WAITING" threadWaiting :: ThreadState

main :: IO ()
main = return ()
