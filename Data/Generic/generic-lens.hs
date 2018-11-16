{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeApplications #-}

import Control.Lens ((^.), (^?), (.~), (&), (#))
import Data.Functor.Identity (Identity)
import Data.Generics.Product (field, position, typed, super, upcast, constraints', the)
import Data.Generics.Sum (_Ctor, _Typed, _As)
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

newtype Skeleton = Skeleton
  { skeleton :: String
  } deriving (Generic, Show)

data Sans = Sans
  { skeleton :: String
  , lazy :: Int
  } deriving (Generic, Show)

sans :: Sans
sans = Sans ";E" 1

lenses :: IO ()
lenses = do
  -- Fields
  print $ sugar ^. field @"sweet"
  print $ sugar & field @"moon" .~ 10003
  -- Sum types
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
  print $ constraints' @Num (twice @Identity) point
  -- Fields, positional, or typical
  print $ sugar ^. the @String
  print $ asgore ^. the @1
  print $ sans ^. the @"skeleton" -- I'm Sans. Sans the skeleton ;E
  where
    twice :: (Applicative f, Num a) => a -> f a
    twice = pure . (*2)

prisms :: IO ()
prisms = do
  -- Constructors
  print $ sugar ^? _Ctor @"Sugar"
  print $ toriel ^? _Ctor @"Toriel"
  print $ asgore ^? _Ctor @"Toriel"
  print (_Ctor @"Asgore" # ":O" :: Fluffy)
  -- Typical
  print $ toriel ^? _Typed @String
  -- Not able to
  --print $ toriel ^? _Typed @()
  -- Constructors, or typical
  print $ toriel ^? _As @"Toriel"
  print $ asgore ^? _As @String

main :: IO ()
main = lenses >> prisms
-- {output}
-- "me"
-- Sugar {sweet = "me", moon = 10003}
-- ":)"
-- "me"
-- 1000
-- "yours"
-- "me"
-- ":)"
-- Skeleton {skeleton = ";E"}
-- Skeleton {skeleton = ";E"}
-- Identity (Point 200 400)
-- "me"
-- ":)"
-- ";E"
-- Just ("me",1000)
-- Just (":D",())
-- Nothing
-- Asgore {kind = ":O"}
-- Nothing
-- Just (":D",())
-- Just ":)"
