{
module Main where
}

%wrapper "basic"

$digit = 0-9

tokens :-
    $white+ ;
    \+ { \s -> TokenPlus }
    \* { \s -> TokenTimes }
    $digit+ { \s -> TokenInt $ read s }
    \( { \s -> TokenParensBegin }
    \) { \s -> TokenParensEnd }

{
data Token = TokenPlus
           | TokenTimes
           | TokenInt Int
           | TokenParensBegin
           | TokenParensEnd
  deriving (Show)

main :: IO ()
main = do
  print $ alexScanTokens "1"
  print $ alexScanTokens "1 + 2"
  print $ alexScanTokens "1 + 2 * 3"
  print $ alexScanTokens "1 + 2 * (3 + 4)"
-- {output}
-- [TokenInt 1]
-- [TokenInt 1,TokenPlus,TokenInt 2]
-- [TokenInt 1,TokenPlus,TokenInt 2,TokenTimes,TokenInt 3]
-- [TokenInt 1,TokenPlus,TokenInt 2,TokenTimes,TokenParensBegin,TokenInt 3,TokenPlus,TokenInt 4,TokenParensEnd]
}
