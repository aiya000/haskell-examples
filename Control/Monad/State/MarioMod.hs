-- if please more, refer to ./State_Exam.hs

import Control.Monad.State

data Mario = Chibi | Deka | Die deriving(Show, Eq)
type Shout = String

letGo :: Shout -> State Mario Shout
letGo = return
--letGo x = return x
--letGo x = state $ \s -> (x,s)

kinoko :: Shout -> State Mario Shout
kinoko _ = state $ \s -> case s of
                      Chibi -> ("hyahoo!!!", Deka)
                      Deka  -> ("poi-n", Deka)
                      Die   -> ("...", Die)


test1 = runState (return "oh.") Chibi
test2 = runState (letGo  "oh!") Chibi

test3 = let story s = letGo s >>= kinoko
        in  runState (story "go.") Chibi

test4 = let story s = return s >>= kinoko
        in  runState (story "go.") Chibi

test5 = let story = kinoko
        in  runState (return "go!" >>= story) Chibi


kuribo :: Shout -> State Mario Shout
kuribo _ = state $ \s -> case s of
                      Chibi -> ("uwaaaaaaa!!!", Die)
                      Deka  -> ("mammami-a!", Chibi)
                      Die   -> ("...", Die)


--test6 = let story = \s -> kinoko s >>= kuribo
--        in  runState (return "let's go!" >>= story) Chibi
test6 = let story s = return s >>= kinoko >>= kuribo >>= kuribo
        in  runState (story "let's go!") Chibi



--- Extra oasobi
rebirth :: Shout -> State Mario Shout
rebirth x = state $ \s -> case s of
                      Die -> (x ++ " ...uooooooo!!!!", Deka)
                      _   -> (x, s)

test7 = let story s = return s >>= kuribo >>= kuribo >>= rebirth
        in  runState (story "let's go!") Chibi
