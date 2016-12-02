import Control.Monad.Fix (fix)


main :: IO ()
main = do
  -- fix f = f (fix f)
  -- ==> f $ f (fix f)
  --  => f $ f $ f (fix f)
  --  => ...
  print $ fix (const 10)
  -- const x _ = x
  -- ==> fix (const 10)
  --  => const 10 $ fix (const 10)
  --  => 10
  --    -- 'const' ignored second argument by lazy evaluating
  print $ take 5 (fix (1:))
  -- => take 5 (fix (1:))
  -- => 1 : take 4 (fix (1:))
  -- => 1 : 1 : take 3 (fix (1:))
  -- => 1 : 1 : 1 : take 2 (fix (1:))
  -- => 1 : 1 : 1 : 1 : take 1 (fix (1:))
  -- => 1 : 1 : 1 : 1 : 1 : take 0 (fix (1:))
  -- => 1 : 1 : 1 : 1 : 1 : []
