{
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

-- |
-- A combination of ./expected_tokens.y and ./line_column_numbers_on_an_error.y.
-- Please see it first :D
module Main where

import Control.Arrow ((>>>))
import Control.Lens
import Control.Monad.Except (MonadError, ExceptT, runExceptT, throwError)
import Control.Monad.State.Strict (MonadState, State, get, evalState)
import Data.Semigroup ((<>))
import Data.String.Here (i)
import Data.Text.Prettyprint.Doc (Pretty(..))
import Safe (readMay)
}

%error { parseError }
%errorhandlertype explist
%monad { Processor }
%name parser
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
-- | A monad for between the lexer and the parser
newtype Processor a = Processor
  { unProcessor :: ExceptT String (State TokenPos) a
  } deriving ( Functor, Applicative, Monad
             , MonadError String
             , MonadState TokenPos
             )

-- | Run and extract a 'Processor'
runProcessor :: Processor a -> Either String a
runProcessor = unProcessor
               >>> (runExceptT :: ExceptT String (State TokenPos) a -> State TokenPos (Either String a))
               >>> (flip evalState initialPos :: State TokenPos (Either String a) -> Either String a)
  where
    -- All code starts with (1, 1)
    initialPos = TokenPos 1 1

-- | A result of the lexer
data Token = TokenInt Int
           | TokenPlus
           | TokenTimes
           | TokenParensBegin
           | TokenParensEnd
  deriving (Show)

instance Pretty Token where
  pretty (TokenInt x)     = pretty x
  pretty TokenPlus        = "+"
  pretty TokenTimes       = "*"
  pretty TokenParensBegin = "("
  pretty TokenParensEnd   = ")"

-- | A position of 'Token' on a code
data TokenPos = TokenPos
  { lineNum :: Int
  , colNum  :: Int
  } deriving (Show)

instance Pretty TokenPos where
  pretty (TokenPos l c) = "(Line=" <> pretty l <> ", Column=" <> pretty c <>")"

_colNum :: Lens' TokenPos Int
_colNum = lens colNum $ \pos n -> pos { colNum = n }

_lineNum :: Lens' TokenPos Int
_lineNum = lens lineNum $ \pos n -> pos { lineNum = n }

-- | A result of the parser
data Expr = ExprPlus Expr Expr
          | ExprTimes Expr Expr
          | ExprParens Expr
          | ExprInt Int
  deriving (Show)

-- | Throw a error with the reason (actual and expected values, where the parser is failed)
parseError :: ([(Token, TokenPos)], [String]) -> Processor a
parseError (((actual, pos):_), expected)
  = throwError [i|parse error at ${show $ pretty pos}, ${show $ pretty actual} is got, but ${show $ pretty expected} are expected.|]
parseError x
  = throwError [i|fatal error! please open an issue with this message X( `${show $ pretty x}`|]

-- | Tokenize a code with the token position
lexer :: String -> Processor [(Token, TokenPos)]
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
        Nothing -> throwError [i|fatal error! please open an issue with this message X( `couldn't read ${show y}`|]
        Just z  -> do
          _colNum <+= length y
          ((TokenInt z, pos):) <$> lexer ys

-- | Run 'lexer' and 'parser'
runApp :: String -> Either String Expr
runApp code = runProcessor $ lexer code >>= parser

main :: IO ()
main = do
  -- This should be succeed
  print $ runApp "1 + 2 * (3 * 4)"
  -- These should be failed
  print $ runApp "1 + *"
  print $ runApp "10 20"
  print $ runApp "+"
-- {output}
-- Right (ExprTimes (ExprPlus (ExprInt 1) (ExprInt 2)) (ExprParens (ExprTimes (ExprInt 3) (ExprInt 4))))
-- Left "parse error at (Line=1, Column=5), * is got, but [int, '('] are expected."
-- Left "parse error at (Line=1, Column=4), 20 is got, but ['+', '*'] are expected."
-- Left "parse error at (Line=1, Column=1), + is got, but [int, '('] are expected."
}
