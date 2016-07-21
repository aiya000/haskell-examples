module ParserBase where


import Prelude hiding (return, fail)


type Parser a = String -> Maybe (a, String)


return :: a -> Parser a
return v = \inp -> Just (v,inp)

fail :: Parser a
fail = \inp -> Nothing


item :: Parser Char
item = \inp -> case inp of []     -> Nothing
                           (x:xs) -> Just (x,xs)


--
parse :: Parser a -> String -> Maybe (a, String)
parse p inp = p inp


-- - - - - - - - - - - - - - - - --


test1 = parse (return 1) "abc"
test2 = parse fail "abc"
test3 = parse item ""
test4 = parse item "abc"
