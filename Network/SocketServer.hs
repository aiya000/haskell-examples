-- See http://yasutech.blogspot.jp/2012/01/haskell.html
import Network
import System.IO
import Control.Exception
import Control.Monad

const' :: IO () -> SomeException -> IO ()
const' = const

main :: IO ()
main = withSocketsDo $ do
  hSetBuffering stdout NoBuffering
  server `catch` (const' $ putStrLn "Exception caught.")
  putStrLn "Connection closed."

server :: IO ()
server = do
  sock <- listenOn (PortNumber 8111)
  forM_ [1..] $ \_ -> do
    (handle,_,_) <- accept sock
    hSetBuffering handle LineBuffering
    msg <- hGetLine handle
    putStrLn msg
    hPutStrLn handle $ "OK !!"
  sClose sock
