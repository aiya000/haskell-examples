import Test.QuickCheck (quickCheck)

class Group a where
  gap   :: a -> a -> a
  gunit :: a
  ginv  :: a -> a

-- abelian group on N set (but isn't Integer)
instance Group Int where
  gap   = (+)
  gunit = 0
  ginv  = negate

 -- {{{

lawAssociative :: [Int] -> Bool
lawAssociative []        = True
lawAssociative [x]       = True
lawAssociative [x,y]     = True
lawAssociative (x:y:z:_) = (x `gap` y) `gap` z == x `gap` (y `gap` z)

testAccociative :: IO ()
testAccociative = quickCheck lawAssociative

lawUnit :: Int -> Bool
lawUnit x =
  let left  = gunit `gap` x == x
      right = x `gap` gunit == x
  in  left && right

testUnit :: IO ()
testUnit = quickCheck lawUnit

lawInverse :: Int -> Bool
lawInverse x =
  let xinv  = ginv x
      left  = xinv `gap` x == gunit
      right = x `gap` xinv == gunit
  in left && right

testInverse :: IO ()
testInverse = quickCheck lawInverse

 -- }}}
