{-# LANGUAGE ConstrainedClassMethods #-}

class UnitedConvertible a where
  toItself :: a -> a
  -- ConstrainedClassMethods allows to restrict constraints in the type class function
  toString :: Show a => a -> String

main :: IO ()
main = return ()
