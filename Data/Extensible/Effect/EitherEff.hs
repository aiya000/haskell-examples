{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}

import Data.Extensible

context :: Eff '["success" >: EitherEff String] ()
context = return ()

context' :: Eff '["failure" >: EitherEff String] ()
context' = throwEff #failure "x("

main :: IO ()
main = do
  print . leaveEff $ runEitherEff @ "success" context
  print . leaveEff $ runEitherEff @ "failure" context'
-- {output}
-- Right ()
-- Left "x("
