import Control.Monad

{- Fundament Monad -} --{{{

plusIntToM :: Int -> Maybe Int
plusIntToM x = Just (x+10)

-- mmm... this cannot apply function.
-- fmon = plusInt (Just 10)

--_-> plusIntToM :: Maybe Int -> Maybe Int !? oh !!
fmon = (Just 10) >>= plusIntToM


-- class Monad m where
--  return :: a -> m a
--  (>>=)  :: m a -> (a -> m b) -> m b
--  (>>)   :: m a -> m b -> mb
--  x >> y = x >>= \_ -> y
--
--  fail :: String -> m a
--  fail msg = error msg

-- instance Monad Maybe where
--  return x = Just x
--  Nothing >>= f  = Nothing
--  Just x  >>= f  = f x
--  fail _ = Nothing


-- Monadic Code !!
fmon'  = return 10 >>= plusIntToM
fmon'' = return 10 >> Nothing >>= plusIntToM



-- omake
tShows = let t = [(1,2),(3,4),(5,6)]
         in  t >>= return . show
{-
(>>=) :: Monad m => m a -> (a -> m b) -> m b
-- for list
(>>=) :: [a] -> (a -> [b]) -> [b]
l >>= f = concat $ map f l

-- ...'concat'!!
-} {-
[(1,2),(3,4),(5,6)] >>= return . show
-- concat $ map (return . show) [(1,2),(3,4),(5,6)]
-- concat [ ["(1,2)"], ["(3,4)"], ["(5,6)"] ]
-- ["(1,2)","(3,4)","(5,6)"]

-- show (1,2) -> return "(1,2)" -> ["(1,2)"]
-> return . show (1,2) -> ["(1,2)"]
-> return . show (3,4) -> ["(3,4)"]
-> return . show (5,6) -> ["(5,6)"]
=> [ ["(1,2)"], ["(3,4)"], ["(5,6)"] ]
=> ["(1,2)","(3,4)","(5,6)"]
-}


--}}}

{- Monad Appendent -} --{{{

--- Definition
-- class Monad m => MonadPlus m where
--  mzero :: m a
--  mplus :: m a -> m a -> m a
--
-- instance MonadPlus [] where
--  mzero = []
--  mplus = (++)
--
-- guard :: (MonadPlus m) => Bool -> m ()
-- guard True  = return ()
-- guard False = mzero

monadPlusG :: Bool -> IO ()
monadPlusG f = do
  putStrLn $ show (guard (f) :: Maybe ())
  putStrLn $ show (guard (f) :: [()])

monadPlusG'  = [1..50] >>= (\x -> guard (x >= 40) >> return x)
monadPlusG'' = do
  x <- [1..50]
  guard (x >= 40)
  return x

--}}}

