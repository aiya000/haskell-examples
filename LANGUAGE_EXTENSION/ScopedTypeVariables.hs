{-# LANGUAGE ScopedTypeVariables #-}

class Some a where
  some  :: a
  toInt :: a -> Int

data Thing = Foo | Bar

instance Some Thing where
  some = Bar
  toInt Foo = 1
  toInt Bar = 2


main :: IO ()
main = print $ (f :: Thing -> Int{- Determine `a` to monomophic type -}) undefined

f :: forall a. Some a => a -> Int
f _ = let x = some :: a  -- Deduce value of `a`
      in toInt x
