import Control.Monad.Writer

-- Logging function with values
applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
applyLog (x, log) f = let (y, newLog) = f x
                      in  (y, log ++ newLog)

numLog x = (x, "Num is " ++ show x ++ " => ")
logging = (30, "Plus 30 => ") `applyLog` numLog



-- ueno ha wakarinikui kara throught de
--- Monadic Writer !

--- Definition
-- instance (Monoid w) => Monad (Writer w) where
--  return x = Writer (x, mempty)
--  (Writer (x,v)) >>= f = let (Writer (y,v')) = f x
--                         in  Writer (y, v `mappend` v')

plus :: Int -> Int -> Writer [String] Int
plus x y = writer (x+y, ["+ " ++ show x ++ " " ++ show y])

logger :: Writer [String] Int
logger = do
  a <- plus 1 2
  b <- plus a 3
  c <- plus b 5
  d <- plus c 8
  return d  -- why need this ?

logPrinter = putStrLn . show $ runWriter logger

tellLog :: Writer [String] Int
tellLog = do
  tell ["message"]
  return 10

main = putStrLn . show $ runWriter tellLog
