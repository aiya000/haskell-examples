{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}

import Control.Monad.Freer
import Control.Monad.Freer.Reader
import Control.Monad.Freer.Writer

context :: ( Member (Reader String) r
           , Member (Writer [String]) r
           ) => Eff r ()
context = do
  x <- ask
  tell [x :: String]

main :: IO ()
main = print . run . runWriter $ flip runReader "hi" (context :: Eff '[Reader String, Writer [String]] ())
