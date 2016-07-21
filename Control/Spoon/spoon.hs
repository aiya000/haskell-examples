import Control.Spoon (spoon)
import Control.DeepSeq (NFData)
import Data.Maybe (fromJust)

-- pure function
chin :: (Show a, Eq a, NFData a) => [a] -> [a]
chin xs =
  -- spoon function using unsafePerformIO
  -- spoon catch some exception on pure function
  let maybeHead = spoon $ head xs
  in if maybeHead == Nothing
    then []
    else [fromJust maybeHead]
