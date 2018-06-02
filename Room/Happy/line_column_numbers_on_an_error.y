{
{-# LANGUAGE QuasiQuotes #-}

module Main where

import Control.Arrow ((>>>))
import Control.Lens
import Control.Monad.State.Strict (State, get, evalState)
import Data.String.Here (i)
import Safe (readMay)
}

%error { parseError }
%monad { Parser }
%name calc
%tokentype { (Token, TokenPos) }

%token
    int { (TokenInt $$, _)      }
    '+' { (TokenPlus, _)        }
    '*' { (TokenTimes, _)       }
    '(' { (TokenParensBegin, _) }
    ')' { (TokenParensEnd, _)   }

%left '*'
%left '+'

%%

Expr : Expr '+' Expr { ExprPlus $1 $3  }
     | Expr '*' Expr { ExprTimes $1 $3 }
     | '(' Expr ')'  { ExprParens $2   }
     | int           { ExprInt $1      }

{
type Parser a = State TokenPos a

data Token = TokenInt Int
           | TokenPlus
           | TokenTimes
           | TokenParensBegin
           | TokenParensEnd
  deriving (Show)

data TokenPos = TokenPos
  { colNum  :: Int
  , lineNum :: Int
  } deriving (Show)

_colNum :: Lens' TokenPos Int
_colNum = lens colNum $ \pos n -> pos { colNum = n }

_lineNum :: Lens' TokenPos Int
_lineNum = lens lineNum $ \pos n -> pos { lineNum = n }

data Expr = ExprPlus Expr Expr
          | ExprTimes Expr Expr
          | ExprParens Expr
          | ExprInt Int
  deriving (Show)

parseError :: [(Token, TokenPos)] -> Parser a
parseError xs = do
  let TokenPos c l = snd $ head xs
  error [i|Parse error at (${show c}, ${show l}) with ${show $ map fst xs}|]

lexer :: String -> Parser [(Token, TokenPos)]
lexer xs = do
  pos <- get
  case xs of
    "" -> pure []
    ('(':xs) -> do
      _colNum <+= 1
      ((TokenParensBegin, pos):) <$> lexer xs
    (')':xs) -> do
      _colNum <+= 1
      ((TokenParensEnd, pos):) <$> lexer xs
    ('*':xs) -> do
      _colNum <+= 1
      ((TokenTimes, pos):) <$> lexer xs
    ('+':xs) -> do
      _colNum <+= 1
      ((TokenPlus, pos):) <$> lexer xs
    (' ':xs) -> do
      _colNum <+= 1
      lexer xs
    ('\n':xs) -> do
      _lineNum <+= 1
      lexer xs
    _ -> do
      let ((y, ys):_) = lex xs
      case readMay y of
        Nothing -> error $ "Lex error with " ++ y
        Just z  -> do
          _colNum <+= length y
          ((TokenInt z, pos):) <$> lexer ys

run :: String -> Expr
run x = flip evalState initialPos $ do
  lexemes <- lexer x
  calc lexemes
  where
    initialPos = TokenPos 1 1

main :: IO ()
main = do
  print $ run "1 + 2 * (3 * 4)"
  print $ run "1 + *"
-- {output}
-- line_column_numbers_on_an_error.hs: Parse error at (5, 1) with [TokenTimes]
-- CallStack (from HasCallStack):
-- error, called at line_column_numbers_on_an_error.hs in main:Main
-- ExprTimes (ExprPlus (ExprInt 1) (ExprInt 2)) (ExprParens (ExprTimes (ExprInt 3) (ExprInt 4)))
}
