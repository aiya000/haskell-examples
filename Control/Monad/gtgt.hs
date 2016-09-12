firstLeftOrLastRight :: [Either e a] -> Either e a
firstLeftOrLastRight = foldr1 (>>)

main :: IO ()
main = do
  let rights   = [Right 1, Right 2, Right 3, Right 4] :: [Either String Int]
  let someLeft = [Right 1, Right 2, Left "oops!", Right 4]
  print $ foldr1 (>>) rights
  print $ foldr1 (>>) someLeft
