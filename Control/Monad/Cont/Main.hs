import Control.Monad.Cont (Cont, cont, runCont, callCC)

-- newtype Cont r a = Cont { runCont :: (a -> r) -> r }
-- (^ fake definition)

-- return :: a -> Cont r a
-- callCC :: ((a -> Cont r b) -> Cont r a) -> Cont r a

-- arrow :: a -> Cont r a


-- succUnder10 is an arrow
succUnder10 :: Int -> Cont r Int
succUnder10 x = cont $ \f ->
  if x < 10 then f $ succ x  -- like `if x < 10 then succ x`
            else f x         --      `          else x     ` but this is ((Int -> r) -> r)


predUnder5 :: Int -> Cont r Int
predUnder5 x = cont $ \f ->
  if x < 5 then f $ pred x
           else f x


{-# ANN contextOfCompose "HLint: ignore Redundant return" #-}
contextOfCompose :: Int -> Cont r Int
contextOfCompose x = do
  y <- succUnder10 x  -- like `let y = succUnder10' x` but this is the monad-bind of Cont
  z <- predUnder5 y
  return z


{-# ANN contextOfLoop "HLint: ignore Redundant lambda" #-}
contextOfLoop :: Int -> Cont r Int
contextOfLoop x = callCC $ body x
  where
    body :: Int -> (Int -> Cont r Int) -> Cont r Int
    body y = \f ->
      if y < 10 then body (succ y) f  -- if y is smaller than 10, go to next with `succ y`
                else return y         -- othewise, stop the loop


main :: IO ()
main = do
  runCont (succUnder10 1) print
  runCont (succUnder10 12) print
  -- the evaluation steps of the value:
  --     runCont (succUnder10 1) print             -- succUnder10 1 :: Cont (IO ()) Int = (Int -> IO ()) -> IO ()
  -- ==> runCont (cont $ \f -> f $ succ 1) print   --
  -- ==> (\f -> f $ succ 1) print                  --
  -- ==> print $ succ 1                            --
  --
  runCont (contextOfCompose 2) print
  runCont (contextOfCompose 5) print
  runCont (contextOfLoop 0) print
  runCont (contextOfLoop 1) print
  runCont (contextOfLoop 100) print
