module ParserCollect ( digit
                     , lower
                     , letter
                     , alphaNum
                     , char
                     , space )
where


import qualified ParserBase as B
import Data.Char


-- Define Parser parts
sat :: (Char -> Bool) -> B.Parser Char
sat p = B.item B.>>= \x ->
        if p x then B.return x else B.fail

digit :: B.Parser Char
digit = sat isDigit

lower :: B.Parser Char
lower = sat isLower

letter :: B.Parser Char
letter = sat isAlpha

alphaNum :: B.Parser Char
alphaNum = sat isAlphaNum

char :: Char -> B.Parser Char
char x = sat (==x)

space :: B.Parser Char
space = sat isSpace


-- Test Parser parts -- {{{
test1  = B.parse digit  "123"
test2  = B.parse digit  "abc"
test3  = B.parse digit  "1bc"
test4  = B.parse digit  ""
test5  = B.parse lower  "abc"
test6  = B.parse lower  "ABC"
test7  = B.parse letter "123"
test8  = B.parse letter "abc"
test9  = B.parse alphaNum "123"
test10 = B.parse alphaNum "abc"
test11 = B.parse alphaNum "ABC"
test12 = B.parse alphaNum "[|]"
test13 = B.parse (char 'a') "123"
test14 = B.parse (char '1') "123"
test15 = B.parse (char 'a') "abc"
test16 = B.parse (char '1') "abc"
test17 = B.parse (char '_') ""
-- }}}
