{-# LANGUAGE TypeFamilies #-}

-- Func is a type level function (a type function).
-- * is kind, and it is a type level type.
type family Func a :: *
type instance Func Int  = Int
type instance Func Bool = Int

type X = Func Int  -- ==> Int
type Y = Func Bool -- ==> Int
type Z = Func Char -- ==> Z

-- :kind! X
-- :kind! Y
-- :kind! Z

-- I don't know how do Z will be defined xD
-- I think Z has no value.


-- The type function can be defined as a partial function.
type family Func' a :: *
type instance Func' Int = Int
--type instance Func' Char = Char
type instance Func' a = Int

-- `Func' Char` cannot be defined,
-- because the type function must save a constraint.
-- `Func' Char` and `Func' a` are conflicted x(


main :: IO ()
main = return ()
