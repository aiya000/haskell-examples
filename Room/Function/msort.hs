-- imcompleted


main :: IO ()
main = print $ msort [1,5,3,6,2,4]


msort :: Ord a => [a] -> [a]
msort []  = []
msort [x] = [x]
msort xs  =
  let n            = length xs `div` 2
      (xs1,  xs2)  = (take n xs, drop n xs)
      (xs1', xs2') = (msort xs1, msort xs2)
  in  if xs1 <= xs2 then xs1 ++ xs2 else xs2 ++ xs1
