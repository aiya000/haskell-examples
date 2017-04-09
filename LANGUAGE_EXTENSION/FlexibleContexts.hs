{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

class LimitedConst a b where
  limitedConst :: a -> b -> a
  limitedConst = const

instance LimitedConst Int Int
instance LimitedConst Char Int


x :: Int
x = 10

y :: Int
y = 20

-- FlexibleContexts
id' :: (LimitedConst a Int) => a -> a
id' = flip limitedConst $ x

main :: IO ()
main = do
  print $ id' y
  print $ id' 'x'
  --print $ id' "ahoge"  -- No instance for (limitedConst String Int)
