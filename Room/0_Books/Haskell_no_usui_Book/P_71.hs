{- 1 -}
natFoo :: Integral a => a -> a -> a
natFoo n 1 = n
natFoo n m = n * (natFoo n (m - 1))
{- 
    natFoo 2 3 =
    2 * (natFoo 2 2) =
    2 * (2 * (natFoo 2 1)) =
    2 * (2 * 2) =
    8
-}


{- 3 -}
and' :: [Bool] -> Bool
and' []     = True
and' (b:bs) = b && and' bs

concat' :: [[a]] -> [a]
concat' [] = []
concat' (xs:xss) = xs ++ (concat' xss)

replicate' :: Int -> a -> [a]
replicate' 0 x = []
replicate' n x = x : replicate' (n-1) x

at :: [a] -> Int -> a
at (x:xs) 0 = x
at (x:xs) n = at xs (n-1)

elem' :: Eq a => a -> [a] -> Bool
elem' x []     = False
elem' x (y:ys) = if x == y then True else x `elem'` ys


{- 4 -}
merge :: Ord a => [a] -> [a] -> [a]
merge xs []     = xs
merge xs (y:ys) = merge (insert y xs) ys
  where
    insert x []     = [x]
    insert x (y:ys) = if x <= y then x:y:ys else y:insert x ys
