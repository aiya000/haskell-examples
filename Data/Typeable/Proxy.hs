{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}

import Data.Proxy (Proxy(..))
import Data.Typeable

data Saya = Saya
  deriving (Typeable)

-- Values of `a` cannot be getten
data Void1 a
deriving instance Typeable a => Typeable (Void1 a)

getTypeNameWithoutValue :: Typeable a => Void1 a -> String
getTypeNameWithoutValue (_ :: Void1 a) = show $ typeRep (Proxy :: Proxy a)


main :: IO ()
main = print $ getTypeNameWithoutValue (undefined :: Void1 Saya)
