{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}

import Data.Extensible

context :: Eff '["io" >: IO] ()
context = liftEff #io $ putStrLn "hi"

main :: IO ()
main = retractEff context
