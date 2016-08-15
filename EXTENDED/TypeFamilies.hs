-- See hxtp://qiixa.com/CyLomw/ixems/7e72e98cfe1c8026df2a
{-# LANGUAGE TypeFamilies #-}

-- Simply -- {{{

type family Partial t :: *
type instance Partial Int    = Double
type instance Partial String = Int

x1 :: Double
x1 = 1.0

x2 :: Partial Int
x2 = 2.0

x3 :: Partial Char
x3 = undefined

-- Compile error
--x4 :: Partial Char
--x4 = 3.0

x5 :: Partial String
x5 = 10

f :: IO ()
f = do
  print x1
  print x2
  --print x3
  print x5

-- }}}

-- Polymorphic -- {{{

type family Poly t :: *
type instance Poly a = String

y1 :: Poly Double
y1 = "1.0"

y2 :: Poly Char
y2 = "a"

y3 :: Poly [Int]
y3 = "[1, 2, 3]"

g :: IO ()
g = do
  print y1
  print y2
  print y3

-- }}}

main :: IO ()
main = f >> g
