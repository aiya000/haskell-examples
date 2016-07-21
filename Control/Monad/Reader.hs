import Control.Monad.Reader (Reader, runReader, ask, reader, local)

main :: IO ()
main = do
  print $ runReader getReader  0
  print $ runReader getReader' 0
  main'

getReader :: Reader Int Int
getReader = do
  a <- ask        -- alike `State (get)
  return $ a + 10

getReader' :: Reader Int Int
getReader' = reader $ \a -> a + 10  -- alike `State (state)`


main' :: IO ()
main' = print localChanged

localChanged :: (Int, Int, Int)
localChanged = (`runReader` 0) $ do
  x <- ask
  y <- local (+10) $ do  -- y knows (+10)
    y' <- ask
    return y'
  z <- ask               -- z doesn't know (+10)
  return (x, y, z)
