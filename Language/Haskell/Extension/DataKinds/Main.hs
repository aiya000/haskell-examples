{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}

data KindFoo = TypeFoo

data Foo (a :: KindFoo) = Refl

x :: Foo TypeFoo
x = Refl

-- to be compile error
--y :: Foo Int
--y = Refl

main :: IO ()
main = return ()
