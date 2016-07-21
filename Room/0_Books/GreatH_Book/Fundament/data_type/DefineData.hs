
{- 型定義(値コンストラクタ) -} --{{{

{- こんなん -} {-
 - struct Point : public Show {
 -   float x, y;
 - };
 -}

--- ここの右辺で行っている定義を「値コンストラクタ」という。
data Point = Point Float Float deriving(Show)
--- deriving(Show)したので表示可能
showPoint x y = show (Point x y)
--- 用法
plusPoint :: Point -> Point -> Point
plusPoint (Point x1 y1) (Point x2 y2) = Point (x1+x2) (y1+y2)
p1 = Point 1 1
p2 = Point 2 2
p3 = p1 `plusPoint` p2
p4 = p1 `plusPoint` p2 `plusPoint` p3

--- Type型の値[Normal, Warn, Emerge]
data Status = Normal | Warn | Emerge deriving(Show)
iToS :: Int -> Status
iToS i =
  case i of  1 -> Warn
             2 -> Emerge
             otherwise -> Normal
--}}}

{- 型定義(レコード構文) -} --{{{
data Person = Person {
  name   :: String,
  age    :: Int,
  height :: Float
} deriving(Show)

aiya = Person {name="aiya", age=20, height=160}

--}}}
