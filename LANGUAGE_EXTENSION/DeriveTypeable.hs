{-# LANGUAGE DeriveDataTypeable #-}

import Data.Typeable (Typeable, typeOf, cast)

data Ahoge = Aho
           | Baka
  deriving (Show, Typeable)

type Bakage = Ahoge


main1 :: IO ()
main1 = do
  print $ typeOf Aho  -- Ahoge
  print $ typeOf Baka -- Ahoge
  print $ typeOf (Aho :: Bakage) -- Ahoge


newtype MyInt = MyInt Int

main2 :: IO ()
main2 = do
  print $ cast'  . MyInt $ 10 -- Nothing
  print $ cast'' 10 -- Nothing
  where
    -- Typeable instance can be applied type-safe cast
    cast' :: MyInt -> Maybe Int
    cast' = cast

    cast'' :: Float -> Maybe Double
    cast'' = cast


main :: IO ()
main = do
  main1
  main2
