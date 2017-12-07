{-# LANGUAGE MagicHash #-}

-- GHC.Prim defines some 'unboxed types',
-- these are named with the case of MagicHash.
--
-- It doesn't mean that MagicHash always means unboxed types,
-- MagicHash only extends the naming case.
import GHC.Prim

type X = Int#
type Y = Char#
type Z = Addr#

data Me# = Me Int

main :: IO ()
main = return ()
--TODO: See GHC.Types of ghc-prim
