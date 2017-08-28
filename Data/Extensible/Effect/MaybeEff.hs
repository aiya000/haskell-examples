{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}

import Data.Extensible

context :: Eff '["success" >: MaybeEff] ()
context = return ()

context' :: Eff '["failure" >: MaybeEff] ()
context' = throwEff #failure ()

main :: IO ()
main = do
  print . leaveEff $ runMaybeEff @ "success" context
  print . leaveEff $ runMaybeEff @ "failure" context'
