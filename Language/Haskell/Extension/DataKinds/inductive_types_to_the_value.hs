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

data instance Sing End = EndS
newtype instance Sing ('Foo x) = FooS (Sing x)

instance SingI 'End where
  sing :: Sing 'End
  sing = EndS

instance SingI a => SingI ('Foo a) where
  sing :: Sing ('Foo a)
  sing = FooS (sing :: Sing a)


-- | the isomorphic type for 'Foo'
data RealFoo = RFoo RealFoo | REnd
  deriving (Show)

newtype SFoo (x :: Foo) = SFoo RealFoo

class KnownFoo (a :: Foo) where
  fooSing :: SFoo a

instance KnownFoo 'End where
  fooSing :: SFoo 'End
  fooSing = SFoo REnd

instance KnownFoo a => KnownFoo ('Foo a) where
  fooSing :: SFoo ('Foo a)
  fooSing = let SFoo x = fooSing :: SFoo a
            in SFoo $ RFoo x

fooVal :: forall proxy a. KnownFoo a => proxy a -> RealFoo
fooVal _ = case fooSing :: SFoo a of
                SFoo x -> x

-- vvv 無限にわからないし、もうfooValでいい vvv
--instance SingKind Foo where
--  type DemoteRep Foo = RealFoo
--  fromSing :: KnownFoo a => Sing a -> RealFoo
--  fromSing EndS = REnd
--  fromSing (FooS x) = RFoo $ fromSing x
--  toSing :: RealFoo -> SomeSing Foo
--  toSing = SomeSing . toSing'
--    where
--      toSing' :: KnownFoo a => RealFoo -> Sing a
--      toSing' REnd = EndS
--      -- x :: RealFoo
--      toSing' (RFoo x) = FooS $ toSing' x
--

fall :: forall (a :: Foo). KnownFoo a => Sing a -> RealFoo
fall _ = let SFoo x' = fooSing :: SFoo a
         in x'

main :: IO ()
main = do
  print $ fooVal (Proxy :: Proxy End)
  print $ fooVal (Proxy :: Proxy ('Foo End))
  print $ fooVal (Proxy :: Proxy ('Foo ('Foo End)))
  print $ fall (sing :: Sing 'End)
