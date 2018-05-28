import Control.Concurrent (threadDelay)
import Data.Time.Calendar (Day)
import Data.Time.Clock (UTCTime(..), DiffTime, getCurrentTime, diffUTCTime)

main :: IO ()
main = do
  x <- getCurrentTime :: IO UTCTime
  let day  = utctDay x     :: Day
  let time = utctDayTime x :: DiffTime
  putStrLn $ "today is " ++ show day
  putStrLn $ "now is "   ++ show time
  threadDelay $ 2 * 1000 * 1000
  y <- getCurrentTime
  print $ diffUTCTime y x
-- {output}
-- today is 2018-05-28
-- now is 48191.858588564s
-- 2.002086728s
