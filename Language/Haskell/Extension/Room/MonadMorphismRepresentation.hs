{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE TypeOperators #-}

import Control.Arrow ((>>>))
import Data.Functor.Identity (Identity(..))

type m :~> n = forall a. m a -> n a


-- A monad morphism
toJust :: Identity :~> Maybe
toJust = runIdentity >>> Just


main :: IO ()
main = do
  let x = Identity 10
  print $ toJust x
