{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE NoPolymorphicComponents #-}

data MyMonad m = MkMonad
  { unit :: forall a. a -> m a
  , bind :: forall a b. m a -> (a -> m b) -> m b
  }

main :: IO ()
main = return ()

-- Compile error !
