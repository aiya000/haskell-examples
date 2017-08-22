{-# LANGUAGE TypeOperators #-}

{-# LANGUAGE TypeOperators #-}

import Control.Arrow ((>>>))
import Control.Eff (Eff, (:>), run)
import Control.Eff.Exception (Exc, runExc, liftEither)
import Control.Eff.Lift (Lift)
import Data.Void (Void)

type PureComputation = Eff (Exc () :> Void)
type ImpureComputation = Eff (Exc () :> Lift IO :> Void)

pureCompute :: PureComputation ()
pureCompute = return ()

impureCompute :: ImpureComputation ()
impureCompute = return ()

upgrade :: PureComputation a -> ImpureComputation a
upgrade = runExc >>> run >>> liftEither

impureCompute' :: ImpureComputation ()
impureCompute' = upgrade pureCompute

main :: IO ()
main = return ()
