{- import -} --{{{
-- import Data.List                    -- 通常インポート
-- import Data.List (nub, sort)        -- モジュール指定インポート
-- import Data.List hiding (num, sort) -- 排他的モジュール指定インポート
-- import qualified Data.Map           -- 完全修飾指定を強制するインポート
--}}}
import qualified Data.List as L    -- 別名指定して修飾を強制するインポート
import qualified Data.Char as C
import qualified Data.Map  as M

{- Data.List -} --{{{
splitWords = L.words "This is a pen"
sortWords  = L.sort . foldl (\ac xs -> ac ++ xs) [] $ take 5 $ repeat splitWords
groupWords = L.group sortWords

calcWordsLen =  -- なんとなく遊んでみる
  let
    count [] = []
    count (xs:xss) = length xs : count xss
  in
    count groupWords

tails_test = L.tails [1..5]
isPrefixOf_test =
  "hawaii" `L.isPrefixOf` "hawaii joe" :
  "hoge"   `L.isPrefixOf` "hoge foo"   :
  "hoge"   `L.isPrefixOf` "foo hoge"   :
  "head"   `L.isPrefixOf` "head tail"  : []
any_test =
  L.any (==True) isPrefixOf_test :
  L.any (==3) [1..5] :
  L.any (==6) [1..5] : []

n `isInfixOf'` h = L.any (n `L.isPrefixOf`) (L.tails h)
--}}}
{- Data.Char -} --{{{
ord_test = C.ord 'a'
chr_test = C.chr 97
caesar num str = map (\c -> C.chr $ C.ord c + num) str

rot13 :: String -> String
rot13 str =  -- シーザしてみる。
  let
    uCaesar = (\c -> C.chr $ C.ord c + 13)
    dCaesar = (\c -> C.chr $ C.ord c - 13)
    caesarCase = (\c ->
      if c > 'N' then
        if c < 'n' then uCaesar c else dCaesar c
      else
        if c < 'N' then uCaesar c else dCaesar c)
  in
    map (caesarCase) str

digitSum :: Int -> Int
digitSum num = sum $ map C.digitToInt $ show num
--}}}
{- Maybe -} --{{{
firstTo :: Int -> Maybe Int
firstTo target = L.find (\x -> (digitSum x) == target) [1..]
  where  digitSum num = sum $ map C.digitToInt $ show num
--}}}
{- Map -} --{{{
phoneBook =
  [("aiya"      , "111-2345"), 
   ("shigure"   , "222-3456"), 
   ("gunshi"    , "333-4567"), 
   ("blacky"    , "444-5678"), 
   ("KillInSun" , "555-6789")]
findByKey :: String -> [(String,String)] -> String
findByKey key ((k,v):book) =
  if k == key then v
  else findByKey key book
-- G's Ans
g_findByKey :: (Eq k) => k -> [(k,v)] -> v
g_findByKey key xs = snd . head . filter (\(k,v) -> key == k) $ xs
-- なんでそこに$かと思ったら、要するにこうなのね。
-- snd . head $ filter (\(k,v) -> key == k) xs

hororon = filter (C.isDigit) $ findByKey "aiya" phoneBook

-- Data.Map.fromListはマップリストの重複を削除する
phoneMap = M.fromList phoneBook
findInPhoneMap key = M.lookup key phoneMap
newPhoneMap = M.insert "lime" "666-7890" phoneMap
newPhoneMapSize = M.size newPhoneMap

ununiqueBook =
  [("aiya" , "111-2345"), 
   ("aiya" , "222-3456"), 
   ("aiya" , "333-4567")]
-- Data.Map.fromListWithはマップリストの重複を許す(ただしそれらの処理が必要になる)
ununiqueMap = M.fromListWith con ununiqueBook
  where  con a b = a ++ "," ++ b
--}}}
