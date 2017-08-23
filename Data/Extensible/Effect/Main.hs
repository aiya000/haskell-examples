{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeApplications #-}

import Data.Extensible (Associate, WriterEff, Eff, tellEff, leaveEff, runWriterEff)

context :: ( Associate "greet" (WriterEff [String]) xs
           , Associate "message" (WriterEff [String]) xs
           ) => Eff xs ()
context = do
  tellEff #greet ["hi"]
  tellEff #message ["extensible, OverloadedLabels, and TypeApplications is great"]
  tellEff #greet ["thanks !"]

main :: IO ()
main = print
       . leaveEff
       . runWriterEff @ "message"
       . runWriterEff @ "greet"
       $ context
