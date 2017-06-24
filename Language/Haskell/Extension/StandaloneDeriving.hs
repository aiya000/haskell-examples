{-# LANGUAGE StandaloneDeriving #-}

data Foo = Foo

deriving instance Show Foo

main :: IO ()
main = print Foo
