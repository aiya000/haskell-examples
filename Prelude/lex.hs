{-# LANGUAGE ViewPatterns #-}

import Test.QuickCheck (quickCheck)

lexTest :: String -> Bool
lexTest = (<=1) . length . lex

main :: IO ()
main = do
  print $ lex "abc123 abc 123"
  print $ lex "abc 123"
  print $ lex "123"
  print $ lex ""
  quickCheck lexTest
-- {output}
-- [("abc123"," abc 123")]
-- [("abc"," 123")]
-- [("123","")]
-- [("","")]
-- +++ OK, passed 100 tests.
