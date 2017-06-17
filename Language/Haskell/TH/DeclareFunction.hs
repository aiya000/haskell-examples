{-# LANGUAGE TemplateHaskell #-}

module DeclareFunction where

import Language.Haskell.TH (Q, DecsQ, Dec(FunD), Clause(Clause), Pat(VarP, WildP), Exp(VarE, LitE), Body(NormalB), Lit(IntegerL), mkName)


-- | Create a function simply
declareFunc :: Q [Dec]
declareFunc = do
  let id' = mkName "id'" -- the name of the function
      x   = mkName "x"   -- the name of "id'"'s an argument
  return [FunD id' [Clause [VarP x] (NormalB $ VarE x) []]]


-- | The const function in the compile time
metaConst :: Int -> DecsQ -- DecsQ is a type synonym of Q [Dec]
metaConst x = do
  let constX = mkName "constX"
      litX = LitE . IntegerL $ fromIntegral x
  return [FunD constX [Clause [WildP] (NormalB $ litX) []]]
