import Control.Monad.State

foo :: State Int Int
foo = state $ \s -> (s + 1, 10)

-- modify state...maybe
--bar :: Int -> State Int Int
bar x = state $ \s -> (s, x + 1)
