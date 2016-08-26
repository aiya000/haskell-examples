main :: IO ()
main = do
  print $ Nothing    >> Just 10
  print $ Left "aho" >> Right 10
  let rights   = [Right 1, Right 2, Right 3, Right 4] :: [Either String Int]
  let someLeft = [Right 1, Right 2, Left "oops!", Right 4]
  print $ foldr1 (>>) rights
  print $ foldr1 (>>) someLeft

firstLeftOrLastRight :: [Either e a] -> Either e a
firstLeftOrLastRight = foldr1 (>>)
