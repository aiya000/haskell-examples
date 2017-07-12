{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}


-- | A modifier for dicriminate a type
data Discriminating :: * -> * where
  DiscrInt      :: Discriminating Int
  DiscrIntToInt :: Discriminating (Int -> Int)

-- | A reversible existential type
data Nico a = forall a. Nico (Discriminating a) a


-- | Discriminate `Nico a`
discriminate :: Nico a -> IO ()
discriminate (Nico DiscrInt x) = putStrLn $ "Int: " ++ show x
discriminate (Nico DiscrIntToInt _) = putStrLn "Int -> Int: _"


main :: IO ()
main = do
  let x = Nico DiscrInt 10
      f = Nico DiscrIntToInt ((+1) :: Int -> Int)
  discriminate x
  discriminate f
