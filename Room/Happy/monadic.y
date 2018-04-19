{
module Main where

import Safe (readMay)
}

%name calc
%tokentype { Token }
%monad { Either String }
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

Expr : Expr '+' Expr {% return $ ExprPlus $1 $3  }
     | Expr '*' Expr {% return $ ExprTimes $1 $3 }
     | '(' Expr ')'  {% return $ ExprParens $2   }
     | int           {% return $ ExprInt $1      }

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

parseError :: [Token] -> Either String a
parseError tokens = Left $ "Parse error: " ++ show tokens

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
  print . calc $ lexer "1"
  print . calc $ lexer "1 + 2"
  print . calc $ lexer "1 + 2 * 3"
  print . calc $ lexer "1 + 2 * (3 * 4)"
-- {output}
-- Right (ExprInt 1)
-- Right (ExprPlus (ExprInt 1) (ExprInt 2))
-- Right (ExprTimes (ExprPlus (ExprInt 1) (ExprInt 2)) (ExprInt 3))
-- Right (ExprTimes (ExprPlus (ExprInt 1) (ExprInt 2)) (ExprParens (ExprTimes (ExprInt 3) (ExprInt 4))))
}
