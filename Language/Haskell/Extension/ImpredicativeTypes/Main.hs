{-# LANGUAGE ImpredicativeTypes #-}
{-# LANGUAGE RankNTypes #-}

f :: Bool -> b -> b
f = const id

g :: (forall a. a -> a) -> Int
g = undefined

foo :: Bool -> Int
foo x = g $ f x

--foo' :: Bool -> Int
--foo' = g . f
-- ^ If this is commented in.
--   The compilation is failed, even `ImpredicativeTypes` is enabled.

main :: IO ()
main = return ()
