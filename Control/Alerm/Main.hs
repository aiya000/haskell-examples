import Control.Alarm
import Control.Monad (void, forM_)
import Control.Timeout
import Data.Time.Units

--FIXME: 1..10 are shown at "NOW" !!!!!!!!! 
main :: IO ()
main = do
  indiceAlarms <- zip [1..] <$> mapM newAlarm ([1..10] :: [Second])
  forM_ indiceAlarms $ \(i, a) -> alarm a . print $ show i
  delay (11 :: Second)
