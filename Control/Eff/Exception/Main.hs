{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE UndecidableInstances #-}

import Control.Eff (Eff, run, Member, (:>), SetMember)
import Control.Eff.Exception (Exc(..), runExc, throwExc)
import Control.Eff.Lift (Lift, lift, runLift)
import Control.Monad.Fail (MonadFail(..))
import Data.Void (Void)
import Prelude hiding (fail)

-- | An isomorphic type of @Maybe@
type Maybe' = Exc ()

instance Member Maybe' r => MonadFail (Eff r) where
  fail _ = throwExc ()


context :: Member Maybe' r => Eff r ()
context = do
  Exc x <- fail "sugar"
  x `seq` return ()


main :: IO ()
main = do
  let x = run $ runExc (context :: Eff (Maybe' :> Void) ())
  print x
