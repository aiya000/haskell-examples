{-# LANGUAGE ImplicitParams #-}

type MonoidDict a = (a, a -> a -> a)

plus :: (?mDict :: MonoidDict a) => a -> a -> a
plus = snd ?mDict

main :: IO ()
main = do
  -- First, `plus 1 (2 :: Int)` finds a `MonoidDict Int`.
  -- Second, `?mDict` is applied to `plus` implicitly.
  let ?mDict = (0, (+)) :: MonoidDict Int
  print $ plus 1 (2 :: Int)
  -- This is same as the last case
  let ?mDict = ("", (++))
  print $ plus "su" "gar"
  -- Always the latest `?mDict` in lexical scope is preferred
  let ?mDict = (0, (-))
  print $ plus 1 (2 :: Int)
-- {output}
-- 3
-- "sugar"
-- -1
