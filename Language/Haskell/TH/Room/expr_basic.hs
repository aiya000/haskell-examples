{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH


func1 = putStrLn "Hello,TH..!!!!"
-- runQ [e| putStrLn "Hello,TH..!!!!" |]
--   => AppE (VarE System.IO.putStrLn) (LitE (StringL "Hello,TH..!!!!"))

func1TH = AppE (VarE 'putStrLn) (LitE (StringL "Hello,TH..!!!!"))
-- 'putStrLn is an Expression Quote ( This is FunctionName Quote on this time. )
--   that is unreal name, I can use this on TH.
-- and System.IO.putStrLn is not an Literal
--   that is real name, I cannot use this on TH.

-- Quote case examples is
--  'print  <- FunctionName Quote, I can use Data Constructors ( 'Just...and etc )
--  "String <- TypeName Quote

printFunc1TH = ppr func1TH
showFunc1TH  = pprint func1TH
-- If you want to real expressionize from template haskell expression,
-- you can use this way.


main :: IO ()
main = do
  func1
  print func1TH
  print printFunc1TH
  print showFunc1TH
