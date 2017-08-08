{-# LANGUAGE DeriveDataTypeable #-}

import Data.Typeable

data Sugar = Sugar String
  deriving (Typeable)

x :: Sugar
x = Sugar "saya is implmenented"


main :: IO ()
main = do
  let representation = typeOf x
  print $ typeRepFingerprint representation
  print $ typeRepArgs representation
  let info = typeRepTyCon representation
  print $ tyConName info
