{-# LANGUAGE MagicHash #-}

import Java hiding (toString)

data {-# CLASS "java.io.File" #-} File = File (Object# File)
  deriving (Class)

foreign import java unsafe "@new"
  newFile :: FilePath -> Java a File

foreign import java unsafe toString :: Object -> String

main :: IO ()
main = do
  file <- java $ newFile "something"
  putStrLn . toString $ superCast file
-- {output}
-- something
