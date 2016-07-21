-- see https://github.com/kqr/gists/blob/master/articles/gentle-introduction-monad-transformers.md

import Control.Applicative (
      Applicative
    , pure
    , (<*>)
    , (<$>)
    , liftA2
    )

data EitherIO e a = EitherIO { runEitherIO :: IO (Either e a) }

instance Functor (EitherIO e) where
  fmap f = EitherIO . fmap (fmap f) . runEitherIO

-- {{{

functorTest :: IO ()
functorTest = do
  let e  = EitherIO (Right <$> getLine) :: EitherIO () String
      e' = fmap (++" !!") e
  runEitherIO e' >>= print

-- }}}

instance Applicative (EitherIO e) where
  pure    = EitherIO . return . Right
  f <*> x = let f'      = runEitherIO f  -- unwrap to `IO (Either e a)`
                x'      = runEitherIO x  -- unwrap to `IO (Either e a)`
                applyer = liftA2 (<*>)   -- lifting to `Either e a`
            in EitherIO $ f' `applyer` x'
