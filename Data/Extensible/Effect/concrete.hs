{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}

import Data.Extensible
import Data.Extensible.Effect.Default

context :: Eff '["x" >: ReaderEff String, "y" >: WriterEff [String]] ()
context = do
  a <- askEff #x
  tellEff #y [a]

main :: IO ()
main = print
       . leaveEff
       . runWriterEff @ "y"
       $ runReaderEff @ "x" context "hi"
