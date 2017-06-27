{-# LANGUAGE ExistentialQuantification #-}

-- A existential type
data Shown = forall a. Show a => Shown a

instance Show Shown where
  show (Shown x) = show x

heteroList :: [Shown]
heteroList = [Shown 10, Shown 10.0, Shown "10"]

main :: IO ()
main = print heteroList
-- vvv output vvv
--[10,10.0,"10"]
