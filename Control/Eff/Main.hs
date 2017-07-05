{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE TypeOperators #-}

import Control.Eff (Eff, Member, run, (:>))
import Control.Eff.Reader.Lazy (Reader, ask, runReader)
import Control.Eff.State.Lazy (State, get, put, runState)
import Control.Eff.Writer.Lazy (Writer, tell, runWriter, runMonoidWriter)

type Logs = [String]


f :: Member (Writer Logs) r => Eff r ()
f = do
  tell ["f"]
  return ()

g :: Member (Reader Logs) r => Eff r Logs
g = do
  x <- ask
  let x' = "g" : x
  return x'

h :: Member (State Logs) r => Eff r ()
h = do
  x <- get
  let x' = "h" : x
  put x'
  return ()


k :: (Member (Writer Logs) r, Member (Reader Logs) r) => Eff r Logs
k = do
  x <- ask
  let x' = "k" : x
  tell x'
  return x'


main :: IO ()
main = do
  let zero     = ([] :: Logs)
      (x, ())  = run $ runWriter (++) zero f
      y        = run $ runReader g zero
      (z, ())  = run $ runState zero h
      -- The type specification is important in extensible-effects (eff often cannot inference)
      (x', ()) = run $ runMonoidWriter (f :: Eff (Writer Logs :> r) ())
      -- runFoo comsumes `a_{n-1}` of `a_1 :> a_2 :> .. :> a_{n-1} :> a_n`.
      -- `run` finishes chains of runFoo.
      x'' = run . runWriter (++) zero
                . flip runReader zero
                . runWriter (++) zero
                . flip runReader zero
                $ (k :: Eff (Reader Logs :>
                             Writer Logs :>
                             Reader Logs :>
                             Writer Logs :> r) Logs)
  print x
  print y
  print z
  print x'
  print x''
-- vvv output vvv
-- ["f"]
-- ["g"]
-- ["h"]
-- ["f"]
-- ([],(["k"],["k"]))
