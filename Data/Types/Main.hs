{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeSynonymInstances #-}

import Data.Types.Injective (Injective(..))
import Data.Types.Isomorphic (Iso(..), from)

type Bool' = Maybe ()


instance Injective Bool' Bool where
  to (Just ()) = True
  to Nothing = False

instance Injective Bool Bool' where
  to True  = Just ()
  to False = Nothing


main :: IO ()
main = do
  print (to $ Just () :: Bool)
  print (from True :: Bool')
