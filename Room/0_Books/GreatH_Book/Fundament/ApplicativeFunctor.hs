import Control.Applicative
import Control.Monad

{- Functor Next Stage -} --{{{

--- IO Functor
iof = do
  inRev <- fmap reverse getLine
  putStrLn inRev

--- Function Connector Functor
nCon x = sum . replicate 3 $ x
fCon x = fmap (sum) (replicate 3) x

--}}}

{- Applicative Functor -} --{{{

--{{{
--
notApplicative =
  let a = Just 10
      Just (b) = a
  in  -- a * 10  <= funny expression !!
      Just (b * 10)

applicative =
  let a = Just 10
  in  (*10) <$> a
applicative' =
  let a = Just 10
  in  fmap (*10) a

aplExam =
  let a = pure 10 :: Maybe Int
      b = Just 10
  in  a == b



aplExam0 =
  (++) <$> ["Kyoko", "Yui", "Chi-na", "Akari"] <*> [" Chan!!"]
aplExam00 =
  (++) <$> ("Ohayo-, "++) <$> ["Kyoko", "Yui", "Chi-na", "Akari"] <*> [" Chan!!"]
aplExam00' =
  fmap (++) ("Ohayo-, "++) <$> ["Kyoko", "Yui", "Chi-na", "Akari"] <*> [" Chan!!"]


--- Hyper Applicative !!!
apFunction  = (*) <$> [1..5] <*> [1..5]
apFunction' = [ x*y | x <- [1..5], y <- [1..5] ]
apFunction0 = [(*0), (*1), (*10)] <*> [1, 2, 3]


--- IO is Applicative Functor !!
ioFunc = do
  get <- (++) <$> getLine <*> getLine
  putStrLn get


--- Function is Applicative Functor !?  YES!!
apFunctFunc = (+) <$> (+1) <*> (+2) $ 1
apFunctFunc0 = (\x y z -> [x,y,z]) <$> (+1) <*> (+2) <*> (+3) $ 5
--
---}}}

-- tyotto... kyu-kei shiyouka.
makeTuple x y = (,) x y
makeTriple x y z = (,,) x y z
-- kyu-kei shuryo!!

---{{{
--

--- ZipList

-- ZipList is not a show instance
examZL = getZipList $ (+) <$> ZipList [1..5] <*> ZipList [10..15]
examZL0 = getZipList $ max <$> ZipList [1..5] <*> ZipList [10..20]
funnyTupleZip = getZipList $ (,) <$> ZipList "hoge" <*> ZipList "foo"

--
---}}}

--}}}

{- Applicative Functions Library -} --{{{

liftWahoo = liftA2 (+) (Just 4) (Just 5)
liftWahoo' = (+) <$> Just 4 <*> Just 5

--- hoge time
justiceList [] = [] :: [Maybe a]
justiceList (x:xs) = Just x : justiceList xs

sequenceA []     = pure []
sequenceA (m:ms) = (:) <$> m <*> sequenceA ms

--- G's Answer
sequenceA' :: (Applicative f) => [f a] -> f [a]
sequenceA' = foldr (liftA2 (:)) (pure [])


--- Oh!
seqDo  = do
  a <- sequence [getLine, getLine, getLine]
  putStrLn $ show a
seqDo' = do
  a <- sequenceA' [getLine, getLine, getLine]
  putStrLn $ show a

--}}}
