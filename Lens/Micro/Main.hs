{-# LANGUAGE TemplateHaskell #-}

import Lens.Micro
import Lens.Micro.TH (makeLenses)
import Lens.Micro.Mtl ((.=))
import Control.Monad.State.Lazy (State, execState)

data Str = Str
  { _x :: Int
  , _y :: String
  } deriving (Show)

makeLenses ''Str


main :: IO ()
main = do
  let str = Str 10 "ahoge"
      str' = execState context str
  print str
  print str'

context :: State Str ()
context = do
  x .= 20
  y .= "baka"
