import Control.Concurrent

main :: IO ()
main = do
  print 10
  threadDelay 1000000  -- micro second
  print 10
