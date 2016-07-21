-- refered to http://qiita.com/pepepe/items/8ab771df76493c3bbd92

import Control.Monad.State

--- Status
data Mario = Chibi | Deka | Die deriving(Show, Eq)

--- Value
type Shout = String


--- Productor
kinoko :: State Mario Shout
kinoko = state body   -- simply notate
  where body s | s == Die  = ("...", Chibi)
               | otherwise = ("hyahoo!!", Die)

kuribo :: State Mario Shout
kuribo = state $ \s -> case s of   -- lambda abstraction
                    Deka -> ("mamma-mia", Chibi)
                    _    -> ("...", Die)

test1 :: (Shout, Mario)
test1 = runState kinoko Chibi


--- Function
tamago :: Shout -> State Mario Shout
tamago x = state $ \_ -> (take 3 x ++ "...Detteiu!!", Die)

test2 :: (Shout, Mario)
test2 = let story = kinoko >>= tamago
        in  runState story Chibi

test3 :: (Shout, Mario)
test3 = let story = kinoko >>= tamago
        in  runState story Deka

--test4 :: (Shout, Mario)
--test4 = let story = kinoko >>= kuribo >>= kinoko >>= tamago
--        in  runState story Chibi
