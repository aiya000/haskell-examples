{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Proxy (Proxy(..))
import Data.Singletons (Sing, SingI(..))

data family HighEquality (x :: k) (y :: k)

data Foo = Bar | Baz

data instance Sing Bar = SBar
data instance Sing Baz = SBaz

instance SingI Bar where
  sing = SBar

instance SingI Baz where
  sing = SBaz

x :: Sing Bar
x = SBar

y :: Sing Baz
y = SBaz

data instance HighEquality Bar Bar = CorrectBarBar
data instance HighEquality Baz Baz = CorrectBazBaz

proof :: HighEquality Bar Bar
proof = CorrectBarBar

main :: IO ()
main = return ()
