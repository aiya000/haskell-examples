{-# LANGUAGE OverloadedStrings #-}

import TextShow (TextShow, showb, showt)
import qualified Data.Text.IO as TIO
import qualified TextShow as TS

data NicoRinPana = Nico | Rin | Pana
  deriving (Show)

instance TextShow NicoRinPana where
  showb Nico = TS.fromText "にこ"
  showb Rin  = TS.fromText "りん"
  showb Pana = TS.fromText "ぱな"


main :: IO ()
main = do
  TIO.putStrLn $ showt Nico
  TIO.putStrLn $ showt Rin
  TIO.putStrLn $ showt Pana
