{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Void (Void)

type family Proof (x :: Bool) :: * where
  Proof 'True = ()
  Proof 'False = Void

proof :: Proof 'True
proof = ()

main :: IO ()
main = putStrLn "Prove"
