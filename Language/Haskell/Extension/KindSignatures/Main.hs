{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE Rank2Types #-}

type High (a :: * -> *) = forall b. a b

data One a = One a

refl :: High a
refl = undefined

main :: IO ()
main = do
  let x = (refl :: High One)
  return ()
