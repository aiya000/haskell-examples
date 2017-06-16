{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH
import Control.Monad


{-

runQ [| \(x,y,z) -> z |]
-- => LamE [TupP [VarP x_0,VarP y_1,VarP z_2]] (VarE z_2)

runQ [| \(_,_,z) -> z |]
-- => LamE [TupP [WildP,WildP,VarP z_3]] (VarE z_3)

-}


thd :: ExpQ
thd = newName "z" >>= \z ->
      lamE [tupP [wildP, wildP, varP z]] (varE z)

select :: Int -> Int -> ExpQ
select length n = do
  vars <- replicateM length $ newName "x"
  lamE [tupP $ map varP vars] (varE
