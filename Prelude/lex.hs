main :: IO ()
main = do
  print $ lex "abc123 abc 123"
  print $ lex "abc 123"
  print $ lex "123"
  print $ lex ""
-- {output}
-- [("abc123"," abc 123")]
-- [("abc"," 123")]
-- [("123","")]
-- [("","")]
