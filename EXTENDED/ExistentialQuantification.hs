{-# LANGUAGE ExistentialQuantification #-}

-- A type for heterogeneous list
data TypeConfuser = forall x. Show x => TypeConfuser x

instance Show TypeConfuser where
  show (TypeConfuser x) = show x


heteroList :: [TypeConfuser]
heteroList = [TypeConfuser 10, TypeConfuser 10.0, TypeConfuser "10"]

main :: IO ()
main = print heteroList
