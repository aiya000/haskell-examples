{- 分岐 -} --{{{
--ex) boomBangs :: [Integer] -> [String]
boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
--}}}

{- cons演算子、リスト結合のテスト -} --{{{
consList = 1 : [0]
-- consList' = [0] : 1  {- コンパイルエラー -}
toList  = [ x : [] | x <- [1,2,3,4,5] ]
toList' = [ x:[] ++ y:[] | x <- [1,2,3,4,5], y <- [1,2,3,4,5] ]
tAlpha  = [ [x, y, z] | x <- ['A'..'z'], y <- ['A'..'z'], z <- ['A'..'z'] ]
match   = [ str | str <- tAlpha, str == "ABC" ]
--}}}

{- タプル -} --{{{
towPareWarn = [ [10, 20], [10, 30], [10, 40, 0] ] -- スリーペアが紛れ込んだっ！！
-- twoPare = [ (10, 20), (10, 30), (10, 40, 0) ]  -- 型不一致でエラー
twoPare = [ (10, 20), (10, 30), (10, 40) ]
mapList = zip [1..] ["Aiya", "Gunshi", "Kill_In_Sun", "Blacky"]
--}}}

{- P.21 Q -} --{{{
-- 直角三角形を見つける
findRTri  = [ [a,b,c] | a <- [1..10], b <- [1..10], c <- [1..10], a^2 + b^2 == c^2, a+b+c == 24]
findRTri' = [ [a,b,c] | c <- [1..10], a <- [1..c], b <- [1..a], a^2 + b^2 == c^2, a+b+c == 24] -- 解答
{----------} --}}}

{- 便利な関数 -} --{{{
intToStr     = show 10
floatToStr   = show 20.0
intConStr    = show 30 ++ "num"

strToInt     = read "10" :: Int  -- 単体では型を明示しよう
strToIntPlus = read "10" + 20    -- 演算により型推論をしてくれる
strToIntType = (read "10"::Float) + 10
tuppleType   = read "(True, 10)" :: (Bool, Float)
--}}}

{- 型クラス -} --{{{
isNum :: (Num a) => a -> Bool
isNum x = True
--}}}

{- パターンマッチ -} --{{{
head' [] = 0
head' (x:_) = x  -- この()はタプルじゃねーぞ多分
snd'  (_:x:_) = x
thd   (_:_:x:_) = x

initial :: String -> Char
initial (s:_) = s

plusTupple (x1, x2) (y1, y2) = (x1+y1, x2+y2)
match0 = [ x | (x,3) <- [(1,1), (2,2), (3,3)] ]
--}}}

{- asパターン -} --{{{
initial' s@(i:_) = s ++ "'s initial is " ++ [i]
--}}}

{- where, let, case -} --{{{

--plusCalc :: [(Integer, Integer)] -> [Integer]
plusCalc :: (Num n) => [(n, n)] -> [n]
plusCalc xs = [ calc x y | (x, y) <- xs ]
	where calc x y = x + y

plusCalc' xs =
	let calc x y = x + y
	in  [ calc x y | (x, y) <- xs ]

inTupple = (let a = 1; b = 2; c = 3; in a * b * c,
			let d = 4; e = 5; f = 6; in d * e * f);


caseOf x = 
	case x of
		[]  -> "Empty"
		[y] -> "Single"
		ys  -> "Longer"

--}}}

{- 再帰 -} --{{{

------
fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = (fibonacci (x-2)) + (fibonacci (x-1))
------

------
maximum' :: (Ord a) => [a] -> a
--maximum' [] = 0
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)
------

------
replicate' :: Int -> a -> [a]
replicate' 0 x = []
replicate' 1 x = [x]
replicate' n x = x : replicate (n-1) (x)
-- GreatH's Answer
replicate'' :: Int -> a -> [a]
replicate'' n x
	| n <= 0    = []
	| otherwise = x : replicate'' (n-1) (x)
------

------
take' :: Int -> [a] -> [a]
take' n xs
	| n <= 0    = []
	| otherwise = head xs : take' (n-1) (tail xs)
-- GreatH's Answer
take'' :: Int -> [a] -> [a]
take'' n _
	| n <= 0 = []
take'' _ []  = []
take'' n (x:xs) = x : take'' (n-1) xs
------

------
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse xs ++ [x] -- OK
------

------
repeat' :: a -> [a]
repeat' x = x : repeat' x  -- OK
------

------
zip' :: [a] -> [b] -> [(a,b)]
-- GreatH's Answer
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys
------

------
elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False  -- OK
elem' c (x:xs)
	| c == x    = True
	| otherwise = elem' c xs
------

------
quicksort :: (Ord a) => [a] -> [a]
-- GreatH's Answer
quicksort [] = []
quicksort (x:xs) =
	let smallerOrEq = [ a | a <- xs, a <= x ]
	    larger      = [ a | a <- xs, a >  x ]
	in  quicksort smallerOrEq ++ [x] ++ quicksort larger
------

--}}}

{- 関数の一部適用 -} --{{{
defaultZip = zip [1..]

zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys
--}}}

{- filter -} --{{{
-- 各要素リストにfを適用、Falseはさらばする。
expFst  = head (filter f [10000..])
	where f x = (x `mod` 3839) == 0
--}}}

{- P.71 -} --{{{
p71  = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))
-- GreatH's other Answer
p71' = sum (takeWhile (<10000) [m | m <- [n^2 | n <- [1..]], odd m])

collatz n
	| n == 1            = [1]
	| (n `mod` 2) == 0  = n : collatz (n `div` 2)
	| otherwise         = n : collatz (n * 3 + 1)

p71_2 = length (collatz 100)
--}}}

{- delay map -} --{{{
delayMap = map (*) [0..]
delayApply = (delayMap !! 5) 5
--}}}

{- lambda expression -} --{{{
-- 1 + 2 * x に特別な意味はあまりないのです。
normally [] = []
normally (x:xs) = f x : normally xs
	where f a = (1 + 2 * a)

lambdaExam [] = []
lambdaExam (x:xs) = (\a -> 1 + 2 * a) x : lambdaExam xs
--}}}

{- fold -} --{{{
-- foldExam :: foldl (アキュムレータ -> リスト要素) -> アキュムレータ型
foldExam = foldl (\x name -> x ++ " " ++ name) "Hello," ["aiya", "gunshi", "killinsun", "blacky"]
foldExam0 = foldr (\x name -> x ++ " " ++ name) "Hello," ["aiya", "gunshi", "killinsun", "blacky"]

-- 普通の実装
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- 畳み込みでの実装
map'' f xs = foldl (\x xs -> x ++ [f xs]) [] xs
--}}}

{- 関数合成, $ -} --{{{
modernF = takeWhile (<100) (map (^2) (zipWith (+) [1..] [1..10]))
chimera = takeWhile (<100) . map (^2) $ zipWith (+) [1..] [1..10]
--}}}
