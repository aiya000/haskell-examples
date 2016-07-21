import Data.Time.Calendar

import Data.Time.LocalTime
import Control.Monad


thd :: (a,b,c) -> c
thd (_,_,t) = t


main = do
  now <- getZonedTime
  let today = localDay $ zonedTimeToLocalTime now
  let month = monthOfDay today
  print $ formatMonth month



startOfMonth :: Day -> Day
startOfMonth d =
  let (y,m,_) = toGregorian d
  in  fromGregorian y m 1

endOfMonth :: Day -> Day
endOfMonth d =
  let (y,m,_) = toGregorian d
  in  fromGregorian y m $ gregorianMonthLength y m

monthOfDay day = [startOfMonth day .. endOfMonth day] :: [Day]


formatMonth :: [Day] -> String
formatMonth mth = toString
  where
    toString =
      let days   = map (show . thd . toGregorian) mth
          daysF  = map (\d -> if length d < 2 then ' ':d else d) days
          cal [] = []
          cal (a:b:c:d:e:f:g:ds) = [a,b,c,d,e,f,g,"\n"] ++ cal ds
      in  foldl (\ac d -> ac ++ ' ' : d) "" daysF --(cal daysF)
