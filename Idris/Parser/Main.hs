{-# LANGUAGE ViewPatterns #-}

import Idris.AbsSyntaxTree (PTerm, idrisInit)
import Idris.Parser (parseExpr)
import Idris.Parser.Stack (ParseError)

val :: String
val = "Nat"

expr :: String
expr = "const 10"

declType :: String
declType = "main : IO ()"

declDef :: String
declDef = "main = printLn 10"

tryParse :: String -> IO ()
tryParse (parseExpr idrisInit -> Left _)  = putStrLn "the parse is error"
tryParse (parseExpr idrisInit -> Right x) = print x

main :: IO ()
main = do
  tryParse val
  tryParse expr
  tryParse declType
  tryParse declDef
-- {output}
-- Nat
-- const (|fromInteger 10 , 10 , 10 , 10 , 10 , 10 , 10 , |)
-- the parse is error
-- (main = (printLn (|fromInteger 10 , 10 , 10 , 10 , 10 , 10 , 10 , |)))
