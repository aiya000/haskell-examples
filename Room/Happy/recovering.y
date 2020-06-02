{
module Main where

import Debug.Trace
}

%error { parseError }
%errorhandlertype explist
%monad { Either String }
%name parseFoo Foo
%name parseBar Bar
%tokentype { Char }

%token
  char { $$ }

%%

Foo :: { String }
  : char {% trace "A" $! Left "error" }
  | char {% trace "B" $! Right "good" }

Bar :: { String }
  : char {% trace "Y" $! Right "good" }
  | char {% trace "X" $! Left "error" }

{
parseError :: ([Char], [String]) -> Either String a
parseError (got, expected) = Left $ show got <> ", " <> show expected

main :: IO ()
main = do
  print $ parseFoo "x"
  print $ parseBar "x"

-- unused rules: 2
-- reduce/reduce conflicts: 2
-- B
-- Right "good"
-- X
-- Left "error"
}
