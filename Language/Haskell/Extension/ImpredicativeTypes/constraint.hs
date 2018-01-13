{-# LANGUAGE ImpredicativeTypes #-}
{-# LANGUAGE RankNTypes #-}

type Monadic m a = Monad m => m a

xs :: [Monadic m Int]
xs = [return 10]

main :: IO ()
main = return ()
