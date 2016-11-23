module Main where

-- | Basic document comment
data Foo = A | B

data Bar = A -- ^ backward comment
           B -- ^ This is B

-- | Link to 'Main.Foo'
type Hoge = Foo
