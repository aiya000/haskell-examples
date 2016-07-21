import Control.Monad.Identity

iA = return 10 :: Identity Int
iB = fmap (+1) iA
iC = iA >>= \i -> return (return i)
iD = join iC


main :: IO ()
main = do
  print $ runIdentity iA
  print $ runIdentity iB
  print $ runIdentity $ runIdentity iC
  print $ runIdentity iD
