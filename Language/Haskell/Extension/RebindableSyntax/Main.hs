{-# LANGUAGE RebindableSyntax #-}

-- RebindableSyntax turns on NoImplicitPrelude
import Prelude hiding (fromInteger)

-- In the Haskell report specification,
-- a literal `1` is expanded to `Prelude.fromInteger (1 :: Integer)`.
--
-- RebindableSyntax changes it to that is expanded to `fromInteger (1 :: Integer)`,
-- also it means `1`'s convertion is able to rebind.
fromInteger :: Integer -> String
fromInteger _ = ";P"

main :: IO ()
main = putStrLn 1
-- {output}
-- ;P
