import Data.Monoid

-- TODO: Use for all in law functions

data Yassu = Yassu Int deriving (Eq,Show)

-- Casual Values
yX      = Yassu 1
yY      = Yassu 2
yZ      = Yassu 3
yUnit   = yX  -- unit element in monoid and group
yNoUnit = yY

-- yassu group's additive operator
(^+^) :: Yassu -> Yassu -> Yassu
(Yassu x) ^+^ (Yassu y) = Yassu $ x + y + 1

--- Num -- {{{

instance Num Yassu where
  x + y                 = x ^+^ y
  (Yassu x) * (Yassu y) = Yassu $ x * y
  abs    (Yassu x)      = if x >= 0 then Yassu x else Yassu (-x)
  negate (Yassu x)      = Yassu $ (-x)
  signum (Yassu x)      = if x == 0 then Yassu 0 else
                          if x >  0 then Yassu 1 else Yassu (-1)
  fromInteger x         = Yassu (fromInteger x)

lawNumSign :: Bool
lawNumSign = abs yX * signum yX == yY

--- }}}
--- Semigroup -- {{{

class Semigroup a where
  sappend :: a -> a -> a

instance Semigroup Yassu where
  sappend = (^+^)

lawSemigroupAssociative :: Bool
lawSemigroupAssociative = yX `sappend` (yY `sappend` yZ) ==
                          (yX `sappend` yY) `sappend` yZ

--- }}}
--- Monoid -- {{{

instance Monoid Yassu where
  mempty  = Yassu (-1)
  mappend = sappend

lawMonoidAssociation :: Bool
lawMonoidAssociation = yX `mappend` (yY `mappend` yZ) ==
                       (yX `mappend` yY) `mappend` yZ
lawMonoidUnit :: Bool
lawMonoidUnit = yUnit   `mappend` yNoUnit ==
                yNoUnit `mappend` yUnit

--- }}}
--- Group -- {{{

class Group a where
  gempty   :: a
  gappend  :: a -> a -> a
  ginverse :: a -> a

instance Group Yassu where
  gempty     = mempty
  gappend    = mappend
  ginverse x = (negate x) - 3

lawGroupAssociation :: Bool
lawGroupAssociation = yX `gappend` (yY `gappend` yZ) ==
                      (yX `gappend` yY) `gappend` yZ
lawGroupUnit :: Bool
lawGroupUnit = yUnit   `gappend` yNoUnit ==
               yNoUnit `gappend` yUnit
lawGroupInverse :: Bool
lawGroupInverse = let yXInverse = ginverse yX
                      yUnit1    = yX        `gappend` yXInverse
                      yUnit2    = yXInverse `gappend` yX
                  in yUnit1 == yUnit2 && yUnit2 == gempty

-- yassu abelian group
lawAbelianGroupCommutation :: Bool
lawAbelianGroupCommutation = yX `gappend` yY == yY `gappend` yX

--- }}}
