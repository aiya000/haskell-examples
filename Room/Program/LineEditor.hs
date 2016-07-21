import Control.Monad
import Control.Applicative
import Control.Exception

import System.IO
import System.Environment

import Data.IORef

import Text.Regex.Posix


main = do
  args <- getArgs
  if length args < 1 then
    putStrLn "ファイルを指定せよ"
  else forM_ args $ \f ->
    lineEdit f

prompt :: String -> IO String
prompt msg = do --{{{
  putStr msg
  hFlush stdout
  getLine --}}}

type FileName = String
type Line  = String
type Text = [Line]
top   = fst
under = snd
type Posit = IORef Int
type EditState = (Posit, Text)


lineEdit :: FileName -> IO ()
lineEdit fileName = do --{{{
  text  <- lines <$> readFile fileName
  state <- newIORef 0
  let edit = (state, text)
  forM_ [0,0..] $ \i -> do
    op <- prompt ":"
    command edit op
--}}}


command :: EditState -> String -> IO ()
command edit op --{{{
  | op =~ "^[0-9]+$" :: Bool = do
      let positLine = (read op :: Int)
      if positLine == 0 then
            modifyIORef (fst edit) (\n -> 0)
      else  modifyIORef (fst edit) (\n -> positLine - 1)

      changed <- readIORef (fst edit)
      if changed > (length $ snd edit) -1 then
            modifyIORef (fst edit) (\n -> (length $ snd edit) - 1)
      else  modifyIORef (fst edit) (\n -> changed)
      command edit "p"

  | otherwise =
        "p" -> do
          posit <- readIORef (fst edit)
          putStr " "
          putStr $ show (posit + 1)
          putStr "|"
          putStrLn $ (snd edit) !! posit

        "d" -> 

        "q" -> error "強制終了の合図です"

        _   -> putStrLn "コマンドないよ"

--}}}

