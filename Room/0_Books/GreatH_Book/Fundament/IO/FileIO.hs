import Control.Monad(when, forever, forM)

import System.IO(openFile, hGetContents, hClose, hPutStrLn)
import System.IO(withFile)
import System.IO(IOMode(WriteMode, ReadMode, AppendMode))
import System.IO(readFile, writeFile, appendFile)

import System.IO(openTempFile)
import System.Directory(removeFile, renameFile)

{- Fundament IO -} --{{{

whenDo = do
  input <- getLine
  when (input == "hoge") $ do
    putStrLn "hogehogehoge!!!"

whenDo' = do
  input <- getLine
  if input == "hoge" then
    putStrLn "hogehogehoge!!!"
  else
    return ()

-----
    
seqDo = do
  rs <- sequence [getLine, getLine, getLine]
  print rs
    
seqDo0 =
  sequence [print 1, print 2, print 3]

seqDo0' =
  sequence $ map print [1..3]

seqDo0'' =
  mapM print [1..3]

seqDo0''' =
  mapM_ print [1..3]

-----
  
everLoopM = forever $ do
  putStr "hoge"

-----

forDo = do
  list <- forM [1..4] $ \i -> do
    print i
    return i
  putStrLn $ show list

--}}}

{- File IO -} --{{{

contentFile = "hogehoge.txt" :: FilePath

-- Basic
wFile = do
  handle <- openFile contentFile WriteMode
  hPutStrLn handle "hogehoge foohoge"
  hClose handle

rFile = do
  wFile
  handle <- openFile contentFile ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle

-- Easier
rWithF = do
  withFile contentFile ReadMode $ \handle -> do
    contents <- hGetContents handle
    putStrLn contents

-- More Easier
rFileE = do
  contents <- readFile contentFile
  putStrLn contents


-- Temporary
tFile = do
  (tempName, tempHandle) <- openTempFile "." "hogeTemp"
  putStrLn $ "I got temp file, that name is [" ++ tempName ++ "]."
  hPutStrLn tempHandle "hoge temp"
  hogeDetail <- hGetContents tempHandle
  putStrLn "temp detail:"
  putStrLn hogeDetail
  hClose tempHandle

  handle <- openFile contentFile ReadMode
  putStrLn $ "I got normally file, that name is [" ++ contentFile ++ "]."

  putStrLn "Detail changing temp detail to normally detail."
  putStrLn "normally detail:"
  detail <- hGetContents handle
  putStrLn detail
  putStrLn "Changing !!"
  hClose handle

  removeFile contentFile
  renameFile tempName contentFile
--}}}

