{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE Rank2Types #-}

import Control.Monad.Identity (Identity(..))
import Control.Monad.State.Lazy (State, get, put, runState, state)
import Data.Bifunctor (second)
import Data.Profunctor (dimap)


x :: Identity Int
x = Identity 10

-- A monad morphism
morph :: Identity a -> State Char a
morph = return . runIdentity

morph' :: State Char a -> State Bool a
morph' cState =
  let f = runState cState
  in state $ dimap changeDomain changeCodomain f
  where
    changeDomain :: Bool -> Char
    changeDomain False = 'a'
    changeDomain True  = 'b'

    changeCodomain :: (a, Char) -> (a, Bool)
    changeCodomain = second $ \case; 'a' -> True
                                   ; _   -> False


main :: IO ()
main = print $ flip runState False . morph' . morph $ x
