module ParserBase ( Parser
                  , ParserBase.return
                  , ParserBase.fail
                  , ParserBase.item
                  , ParserBase.parse
                  , (ParserBase.>>=)
                  , (+++) )
where


-- Define Type of Parser
type Parser a = String -> Maybe (a, String)  -- (result, rest)

-- Define Parser's functions
return :: a -> Parser a
return v = \inp -> Just (v,inp)

fail :: Parser a
fail = \inp -> Nothing

item :: Parser Char
item = \inp -> case inp of []     -> Nothing
                           (x:xs) -> Just (x,xs)

parse :: Parser a -> String -> Maybe (a, String)
parse p inp = p inp   -- abstract implementation


-- Test of over functions -- {{{
test1 = let f = ParserBase.return "hoge"
        in  f "foo"
test2 = ParserBase.fail "hoge"
test3 = item "hoge"
test4 = item ""
test5 = parse (ParserBase.return 1) "hoge"
test6 = parse ParserBase.fail "hoge"
test7 = parse item "hoge"
test8 = parse item ""
-- }}}


-- Define Parser's bind
(>>=) :: Parser a -> (a -> Parser b) -> Parser b
p >>= f = \inp -> case parse p inp of
  Nothing      -> Nothing
  Just (v,out) -> parse (f v) out
-- :t ParserBase.return "hoge" ParserBase.>>= ParserBase.return


-- Test of bind -- {{{

--test9 :: Parser (Char, Char)
test9 = do   -- ??? 'do' using Prelude functions?... failure test.
  x <- item
  item
  y <- item
  ParserBase.return (x,y)

test10 :: Parser (Char, Char)
test10 = item ParserBase.>>= \v1 ->   -- expand non sugar... succeed test.
         item ParserBase.>>= \_  ->
         item ParserBase.>>= \v2 ->
         ParserBase.return (v1,v2)
test11 = test10 "hoge"
test12 = test10 "fo"

test13 :: Parser (Char, Char)
test13 = item            ParserBase.>>= \v1 ->
         ParserBase.fail ParserBase.>>= \_  ->   -- banana
         item            ParserBase.>>= \v2 ->
         ParserBase.return (v1,v2)
test14 = test13 "hoge"
test15 = test13 "fo"

-- }}}


-- Define Parser's selector
(+++) :: Parser a -> Parser a -> Parser a
p +++ q = \inp -> case parse p inp of
  Nothing      -> parse q inp
  Just (v,out) -> Just (v,out)


-- Test of selector -- {{{
test16 = ParserBase.return "hoge" +++ ParserBase.return "foo" $ "aho"
test17 = ParserBase.fail          +++ ParserBase.return "foo" $ "aho"
test18 = ParserBase.fail          +++ ParserBase.fail         $ "aho"

test19 = parse (ParserBase.return "hoge" +++ ParserBase.return "foo") "aho"   -- abstract apply
test20 = parse (ParserBase.fail          +++ ParserBase.return "foo") "aho"
test21 = parse (ParserBase.fail          +++ ParserBase.fail        ) "aho"
-- }}}


(>>) :: Parser a ->  Parser a -> Parser a
p >> q = parse p ParserBase.>>= \_ -> parse q
