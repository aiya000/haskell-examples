import qualified ParserBase    as B
import qualified ParserCollect as C


-- Define Parser (part 1)
string :: String -> B.Parser String
string []     = B.return []
string (x:xs) = C.char x  B.>>= \x'  ->
                string xs B.>>= \xs' ->
                B.return (x':xs')

many :: B.Parser a -> B.Parser [a]
many p = many1 p B.+++ B.return []

many1 :: B.Parser a -> B.Parser [a]
many1 p = p      B.>>= \v  ->
          many p B.>>= \vs ->
          B.return (v:vs)


-- Test Parser (part 1) -- {{{
test1 = B.parse (string "abc") "abc"
test2 = B.parse (string "abc") "abcd"
test3 = B.parse (string "ab12") "abcd"

test4 = B.parse (many C.digit) "123abc"
test5 = B.parse (many $ C.char '1') "123abc"
test6 = B.parse (many $ C.char '2') "123abc"
test7 = B.parse (many $ string "123") "123abc"

test8  = B.parse (many1 C.digit) "123abc"
test9  = B.parse (many1 $ C.char '1') "123abc"
test10 = B.parse (many1 $ C.char '2') "123abc"
test11 = B.parse (many1 $ string "123") "123abc"
-- }}}


-- Define Parser (part 2)
ident :: B.Parser String
ident = C.lower         B.>>= \x  ->   -- portray camel case
        many C.alphaNum B.>>= \xs ->
        B.return (x:xs)

nat :: B.Parser Int
nat = many1 C.digit B.>>= \xs ->
      B.return $ read xs

brank :: B.Parser ()
brank = many C.space >> B.return ()

-- Test Parser (part 2)
test12 = B.parse ident "abc123"
test13 = B.parse ident "123abc"

test14 = B.parse nat "123abc"
test15 = B.parse nat "abc123"
--test16 = B.parse 
