{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}

data family KindConst (x :: k)
data instance KindConst Int = KConstInt

type X = KindConst Int

x :: X
x = KConstInt

data Foo = Bar

data instance KindConst Bar = KConstFoo Foo
type Y = KindConst Bar

y :: Y
y = KConstFoo Bar

main :: IO ()
main = return ()
