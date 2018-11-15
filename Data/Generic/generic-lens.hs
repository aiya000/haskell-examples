{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}

import Control.Lens ((^.), (^?), (.~), (&), (#))
import Data.Generics.Product (field, position, typed, super, upcast, constraints')
import Data.Generics.Sum (_Ctor, _Typed)
import GHC.Generics (Generic)

data Sugar = Sugar
  { sweet :: String
  , moon :: Int
  } deriving (Generic, Show)

sugar :: Sugar
sugar = Sugar "me" 1000

data Fluffy = Asgore { kind :: String }
            | Toriel { kind :: String, aggressive :: () }
  deriving (Generic, Show)

asgore :: Fluffy
asgore = Asgore ":)"

toriel :: Fluffy
toriel = Toriel ":D" ()

data Point = Point Int Int
  deriving (Generic, Show)

point :: Point
point = Point 100 200

data Skeleton = Skeleton
  { bones :: String
  } deriving (Generic, Show)

data Sans = Sans
  { bones :: String
  , lazy :: Int
  } deriving (Generic, Show)

sans :: Sans
sans = Sans ";E" 1

lenses :: IO ()
lenses = do
  print $ sugar ^. field @"sweet"
  print $ sugar & field @"moon" .~ 20
  -- Product types
  print $ asgore ^. field @"kind"
  -- Not able to
  --print $ toriel ^. field @"kind"
  -- Positional
  print $ sugar ^. position @1
  print $ sugar ^. position @2
  print $ (10, ("yours", "mine")) ^. position @2 . position @1
  -- Not able to
  --print $ asgore ^. position @1
  --print $ toriel ^. position @1
  -- Typical
  print $ sugar ^. typed @String
  print $ asgore ^. typed @String
  -- Not able to
  --print $ toriel ^. typed @Int
  --print $ point ^. typed @Int
  -- Structual
  print $ sans ^. super @Skeleton
  print (upcast sans :: Skeleton)
  -- Constraints
  -- print $ constraints' @Num twice point
  where
    twice :: Num a => a -> a
    twice = (* 2)

prisms :: IO ()
prisms = do
  -- Constructors
  print $ toriel ^? _Ctor @"Toriel"
  print $ asgore ^? _Ctor @"Toriel"
  print $ sugar ^? _Ctor @"Sugar"
  print (_Ctor @"Asgore" # ":O" :: Fluffy)
  -- Typical
  print $ toriel ^? _Typed @String
  -- Not able to
  --print $ toriel ^? _Typed @()

main :: IO ()
main = lenses >> prisms
