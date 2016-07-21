{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH


-- Name to Expression
nameX = 10 :: Int
varX = $(varE $ mkName "nameX") :: Int
