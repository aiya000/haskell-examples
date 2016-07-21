-- See http://yasutech.blogspot.jp/2012/01/haskell.html
import Network
import System.IO

main :: IO ()
main = sendMessage "hey!!"

sendMessage :: String -> IO ()
sendMessage msg = withSocketsDo $ do
  hSetBuffering stdout NoBuffering
  handle <- connectTo "127.0.0.1" (PortNumber 8111)
  hSetBuffering handle LineBuffering
  hPutStrLn handle msg
  resp   <- hGetLine handle
  putStrLn resp
  hClose handle
