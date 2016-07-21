{-# LANGUAGE OverloadedStrings #-}
import Data.Text ( Text, pack )
import qualified Data.Text.IO as TIO
import System.Random.Shuffle

type ZuQueue = [Text]

genDoko :: IO Text
genDoko = do
  zun <- shuffleM [pack "ズン", pack "ドコ"]
  return . head $ zun

zuqueue :: IO ZuQueue
zuqueue = do
  zun  <- genDoko
  doko <- zuqueue
  return $ zun : doko

main :: IO ()
main = do
  q <- zuqueue
  mapM_ TIO.putStrLn $ take 10 q
