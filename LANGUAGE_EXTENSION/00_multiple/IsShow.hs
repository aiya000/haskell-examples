{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE Rank2Types #-}

type IsShow a = forall b. Show (a b) => a b

data One a = Refl
  deriving (Show)

refl :: IsShow a
refl = undefined

main :: IO ()
main = do
  let x = (refl :: IsShow One)
  return ()
