{-# LANGUAGE TypeOperators #-}

import Control.Eff (Eff, (:>), run)
import Control.Eff.Exception (Exc)
import Control.Eff.Writer.Lazy (Writer, runWriter)
import Data.Void (Void)

-- | A concrete `Eff`
type MyEff = Eff (Exc String :> Writer Int :> Void)

-- | A concrete `Eff` too
type YourEff = Eff (Writer Int :> Void)

{-
  MyEff > YourEff
-}

mine :: MyEff ()
mine = return ()

yours :: YourEff ()
yours = return ()

--NOTE: A Free with Union convertion maybe needed
-- | Increase your effect
yoursIsMine :: YourEff a -> MyEff a
yoursIsMine = return . snd . run . runWriter (+) 0

mine' :: MyEff ()
mine' = yoursIsMine yours

main :: IO ()
main = return ()
