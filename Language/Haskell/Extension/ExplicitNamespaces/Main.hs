{-# LANGUAGE ExplicitNamespaces #-}

-- `ExplicitNamespaces` allows 'type' keyword in import/export
import Helper (type (-<|), (-<|))

x :: (-<|) Int Char
x = 10 -<| 'a'

main :: IO ()
main = return ()
