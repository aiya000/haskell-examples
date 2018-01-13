{-# LANGUAGE RankNTypes #-}

f :: (forall a. [a] -> [a]) -> ([Int], String)
f g = (g [1, 2, 3], g "sugar")

twice :: [a] -> [a]
twice xs = xs ++ xs

main :: IO ()
main = print $ f twice
