-- See http://qiita.com/CyLomw/items/a618b7c7326d9abede63

-- (enumerate n) is eta_Int of Kleisli triple
enumerate :: Int -> Int -> [Int]
enumerate n m = [n .. (n + m)]

-- Arrow of Kleisli Category
kleisliArrow :: Int -> [Int]
kleisliArrow = concat . map (enumerate 1) . (enumerate 1)

-- and [] is mapping of Kleisli triple

-- ([], eta, ??) is 'Kleisli triple

exam1 :: [Int]
exam1 = kleisliArrow 5
