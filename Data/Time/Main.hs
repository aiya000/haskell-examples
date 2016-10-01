import Data.Time.Clock (UTCTime(..), DiffTime, getCurrentTime)
import Data.Time.Calendar (Day)

main :: IO ()
main = do
  x <- (getCurrentTime :: IO UTCTime)
  let day  = utctDay x     :: Day
  let time = utctDayTime x :: DiffTime
  putStrLn $ "today is " ++ show day
  putStrLn $ "now is "   ++ show time
