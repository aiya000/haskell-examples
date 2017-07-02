import Control.Exception.Safe (MonadCatch, catch, SomeException)
import Control.Monad (mzero)
import Control.Monad (void)
import Control.Monad.Trans.Either (EitherT(..), runEitherT)
import Control.Monad.Trans.Maybe (MaybeT(..), runMaybeT)
import Control.Monad.Trans.State.Lazy (StateT, runStateT)


main :: IO ()
main = do
  case pureContext of
    Left e -> print $ "Left: " ++ show e
    Right a -> print $ "Right: " ++ show a
    `catch` \e -> print $ "SomeException: " ++ show (e :: SomeException)
  case pureMaybeContext of
    Nothing -> putStrLn "Nothing"
    Just x -> print $ "Just: " ++ show x
    `catch` \e -> print $ "SomeException: " ++ show (e :: SomeException)

  x <- runMaybeT inpureMaybeContext
  case x of
    Nothing -> putStrLn "Nothing"
    Just a -> print $ "Just: " ++ show a
    `catch` \e -> print $ "SomeException: " ++ show (e :: SomeException)

  y <- runEitherT (inpureEitherContext :: EitherT String IO ())
  case y of
    Left e -> print $ "Left: " ++ e
    Right a -> print $ "Right: " ++ show a
    `catch` \e -> print $ "SomeException: " ++ show (e :: SomeException)

  z <- runEitherT (inpureEitherContext :: EitherT [Int] IO ())
  case z of
    Left e -> print $ "Left: " ++ show e
    Right a -> print $ "Right: " ++ show a
    `catch` \e -> print $ "SomeException: " ++ show (e :: SomeException)

  (void $ runStateT stateTContext ())
  `catch` \e -> print $ "SomeException: " ++ show (e :: SomeException)


pureContext :: MonadCatch m => m ()
pureContext = do
  let (Just x) = (Nothing :: Maybe ())
  x `seq` return ()

pureMaybeContext :: Maybe ()
pureMaybeContext = do
  Just x <- Nothing
  x `seq` return ()

inpureMaybeContext :: MaybeT IO ()
inpureMaybeContext = do
  x <- mzero -- mzero is MaybeT's Nothing
  x `seq` return ()

-- | (Monad m, Monoid e) => MonadPlus (EitherT e m)
inpureEitherContext :: (Monoid e) => EitherT e IO ()
inpureEitherContext = do
  x <- mzero
  x `seq` return ()


-- | @StateT () IO@'s failure is transmitted to @IO ()@ (main)
stateTContext :: StateT () IO ()
stateTContext = fail "failure in stateTContext"
