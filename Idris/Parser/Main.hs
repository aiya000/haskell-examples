{-# LANGUAGE ViewPatterns #-}

import Idris.AbsSyntaxTree (PTerm, idrisInit)
import Idris.Parser (parseExpr)
import Idris.Parser.Stack (ParseError)

code :: String
code = "10"

code' :: String
code' = "Nat"

code'' :: String
code'' = "main = printLn 10"

tryParse :: String -> IO ()
tryParse (parseExpr idrisInit -> Left _)  = putStrLn "the parse is error"
tryParse (parseExpr idrisInit -> Right x) = print x

main :: IO ()
main = do
  tryParse code
  tryParse code'
  tryParse code''
-- {output}
-- (|fromInteger 10 , 10 , 10 , 10 , 10 , 10 , 10 , |)
-- Nat
-- (main = (printLn (|fromInteger 10 , 10 , 10 , 10 , 10 , 10 , 10 , |)))
