{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Proxy (Proxy(..))
import Data.Singletons (SingI(..), Sing, SingKind(..), SomeSing(..))

-- | inductive structure
data Foo = Foo Foo | End

data instance Sing (a :: Foo) where
  EndS :: Sing 'End
  FooS :: Sing a -> Sing ('Foo a)

instance SingI 'End where
  sing :: Sing 'End
  sing = EndS

instance SingI a => SingI ('Foo a) where
  sing :: Sing ('Foo a)
  sing = FooS (sing :: Sing a)


-- | the isomorphic type for 'Foo'
data RealFoo = RFoo RealFoo | REnd
  deriving (Show)

instance SingKind Foo where
  type DemoteRep Foo = RealFoo
  fromSing EndS     = REnd
  fromSing (FooS s) = RFoo (fromSing s)
  toSing REnd     = SomeSing EndS
  toSing (RFoo r) = case toSing r of
                         SomeSing s -> SomeSing (FooS s)


main :: IO ()
main = do
  print $ fromSing (sing :: Sing 'End)
  print $ fromSing (sing :: Sing ('Foo 'End))
-- {output}
-- REnd
-- RFoo REnd
