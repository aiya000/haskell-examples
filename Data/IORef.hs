import Data.IORef (newIORef, modifyIORef, readIORef)

main :: IO ()
main = getIORef >>= print

getIORef :: IO Int
getIORef = do
  a  <- newIORef 0
  modifyIORef a (+10)
  readIORef a
