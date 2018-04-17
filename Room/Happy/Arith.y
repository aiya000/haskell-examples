{
module Main where

import Control.Arrow ((>>>))
import Safe (readMay)
}
%name calc
%tokentype { Token }
%error { parseError }

%token
    int { TokenInt $$      }
    '+' { TokenPlus        }
    '*' { TokenTimes       }
    '(' { TokenParensBegin }
    ')' { TokenParensEnd   }

%left '*'
%left '+'

%%

Expr : Expr '+' Expr { ExprPlus $1 $3  }
     | Expr '*' Expr { ExprTimes $1 $3 }
     | '(' Expr ')'  { ExprParens $2   }
     | int           { ExprInt $1      }

{
data Token = TokenInt Int
           | TokenPlus
           | TokenTimes
           | TokenParensBegin
           | TokenParensEnd
  deriving (Show)

data Expr = ExprPlus Expr Expr
          | ExprTimes Expr Expr
          | ExprParens Expr
          | ExprInt Int
  deriving (Show)

parseError :: [Token] -> a
parseError xs = error $ "Parse error with " ++ show xs

lexer :: String -> [Token]
lexer "" = []
lexer ('(':xs) = TokenParensBegin : lexer xs
lexer (')':xs) = TokenParensEnd   : lexer xs
lexer ('*':xs) = TokenTimes : lexer xs
lexer ('+':xs) = TokenPlus  : lexer xs
lexer (' ':xs) = lexer xs
lexer xs =
  let ((y, ys):_) = lex xs in
  case readMay y of
    Just z  -> TokenInt z : lexer ys
    Nothing -> error $ "Lex error with " ++ y

main :: IO ()
main = do
  print $ lexer "1"
  print $ lexer "1 + 2"
  print $ lexer "1 + 2 * 3"
  print $ lexer "1 + 2 * (3 * 4)"
  print . calc $ lexer "1"
  print . calc $ lexer "1 + 2"
  print . calc $ lexer "1 + 2 * 3"
  print . calc $ lexer "1 + 2 * (3 * 4)"
-- {output}
-- [TokenInt 1]
-- [TokenInt 1,TokenPlus,TokenInt 2]
-- [TokenInt 1,TokenPlus,TokenInt 2,TokenTimes,TokenInt 3]
-- [TokenInt 1,TokenPlus,TokenInt 2,TokenTimes,TokenParensBegin,TokenInt 3,TokenTimes,TokenInt 4,TokenParensEnd]
-- ExprInt 1
-- ExprPlus (ExprInt 1) (ExprInt 2)
-- ExprTimes (ExprPlus (ExprInt 1) (ExprInt 2)) (ExprInt 3)
-- ExprTimes (ExprPlus (ExprInt 1) (ExprInt 2)) (ExprParens (ExprTimes (ExprInt 3) (ExprInt 4)))
}
