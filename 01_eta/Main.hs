{-# LANGUAGE MagicHash #-}

import Java

data {-# CLASS "java.io.File" #-} File = File (Object# File)
  deriving (Class)

foreign import java unsafe "@new"
  newFile :: FilePath -> Java a File

foreign import java unsafe "toString"
  toStringFile :: Java File String

main :: IO ()
main = java $ do
  file <- newFile "/home/aiya000"
  x    <- file <.> toStringFile
  io $ putStrLn x
