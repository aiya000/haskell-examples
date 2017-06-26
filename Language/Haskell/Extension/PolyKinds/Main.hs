{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}

data FooKind = TypeA | TypeB

type family F (a :: k) :: k
type instance F Int   = Int   -- :: *
type instance F TypeA = TypeB -- :: FooKind
--type instance F TypeB = Char  -- ! kinds are mismatched

type X = F Int
type Y = F TypeA


main :: IO ()
main = return ()
