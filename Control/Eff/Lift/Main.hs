{-# LANGUAGE FlexibleContexts #-}

import Control.Eff (Eff, Member, SetMember)
import Control.Eff.Lift (Lift, lift, runLift)
import Control.Eff.Reader.Lazy (Reader, ask, runReader)
import Data.Void (Void)

type Logs = [String]

zero :: Logs
zero = []


f :: ( Member (Reader Logs) r     -- Define a `Member` of eff
     , SetMember Lift (Lift IO) r -- `SetMember` set an effect extension, `Lift` lifts a `Monad` to an `Eff` effect
     ) => Eff r ()
f = do
  x <- ask
  lift $ print (x :: Logs)
  return ()


main :: IO ()
main = runLift $ runReader f zero
