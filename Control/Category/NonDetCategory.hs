import Prelude hiding ((.), id)
import Control.Category

-- See :t (.)
-- See :t id

-- See NonDet.hs
newtype NonDet i o = NonDet { runNonDet :: i -> [o] }

instance Category NonDet where
  -- See KleisliTriple.hs
  (.) (NonDet f) (NonDet g) = NonDet $ concat . map f . g
  id = NonDet $ \x -> [x]


enumerate :: Int -> Int -> [Int]
enumerate n m = [n .. (n + m)]

enumerate' :: Int -> NonDet Int Int
enumerate' n = NonDet $ enumerate n

exam1 :: [Int]
exam1 = runNonDet (enumerate' 2) 5

exam2 :: [Int]
exam2 =
  let arrow = (enumerate' 1) . (enumerate' 1)
  in runNonDet arrow 5

exam3 :: [Int]
exam3 =
  let arrow = (enumerate' 3) . (enumerate' 2) . (enumerate' 1) . (enumerate' 0)
  in runNonDet arrow 3


-- Category law {{{

unitLaw1 :: Bool
unitLaw1 =
  let arrow  = (enumerate' 2)
      withId = runNonDet (id . arrow) 3
      normal = runNonDet arrow 3
  in  withId == normal

unitLaw2 :: Bool
unitLaw2 =
  let arrow = (enumerate' 2)
      left  = runNonDet (id . arrow) 3
      right = runNonDet (arrow . id) 3
  in  left == right

composeLaw :: Bool
composeLaw =
  let left     = ((enumerate' 2) . (enumerate' 1)) . (enumerate' 0)
      right    = (enumerate' 2) . ((enumerate' 1) . (enumerate' 0))
      leftVal  = runNonDet left  4
      rightVal = runNonDet right 4
  in leftVal == rightVal

-- }}}
-- Functions {{{

-- Alternate (Category..)
exam4 :: Bool
exam4 =
  let compose1 = (enumerate' 2) . (enumerate' 1)
      compose2 = (enumerate' 2) <<< (enumerate' 1)
      compose3 = (enumerate' 1) >>> (enumerate' 2)
      val1     = runNonDet compose1 4
      val2     = runNonDet compose2 4
      val3     = runNonDet compose3 4
  in  val1 == val2 && val2 == val3

-- }}}
