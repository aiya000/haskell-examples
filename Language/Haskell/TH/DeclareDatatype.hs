{-# LANGUAGE TemplateHaskell #-}

module DeclareDatatype where

import Language.Haskell.TH ( DecsQ, mkName, Dec(NewtypeD), Con(NormalC)
                           , Bang(Bang), SourceUnpackedness(NoSourceUnpackedness), SourceStrictness(NoSourceStrictness)
                           , Type(ConT)
                           )


declareNewInt :: DecsQ
declareNewInt = do
  let newInt = mkName "NewInt"
  return [ NewtypeD []                                                        -- newtype
             newInt [] Nothing                                                --  NewInt =
             (NormalC newInt [ ( Bang NoSourceUnpackedness NoSourceStrictness --    NewInt
                               , ConT $ mkName "Int")])                       --      Int
             [ConT $ mkName "Show"]                                           --  deriving (Show)
         ]
