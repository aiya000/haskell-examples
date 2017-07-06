{-# LANGUAGE TemplateHaskell #-}

import Lens.Micro
import Lens.Micro.TH (makeLenses, makeLensesFor)
import Lens.Micro.Mtl ((.=))

data Big = Big
  { _num   :: Int
  , _small :: Small
  } deriving (Show)

data Small = Small
  { _x :: Char
  , _y :: String
  } deriving (Show)

makeLenses ''Big
-- This usecase is same as makeLenses
makeLensesFor [ ("_x", "x")
              , ("_y", "y")
              ] ''Small


big :: Big
big = Big
  { _num = 10
  , _small = Small 'a' "sugar"
  }


main :: IO ()
main = do
  -- ASetter (it is num, small, x, and y) can be composed by (.)
  -- It is important that the flow is left to right
  let a = big ^. small . x
  print a
  -- The locally field can be updated easily
  let big'  = big & small . x .~ 'b'
  let big'' = big' & small . y %~ (++ "-sugar")
  print big'
  print big''
