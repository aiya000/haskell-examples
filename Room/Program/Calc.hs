import qualified Data.Char as C

calc :: String -> Int
calc expr =
  let
    zero = C.ord '0'
  in
    foldl1 (\ac n -> if numIsOperator n then numToOperator n $ ac-zero else ac (n-zero)) $ strToIntList expr
  where
    numToOperator i =
      let a = (C.ord '+')
          b = (C.ord '-')
          c = (C.ord '*')
          d = (C.ord '/')
      in case i of a -> (+)
                   b -> (-)
                   c -> (*)
                   d -> div
    numIsOperator :: Char -> Bool
    numIsOperator i =
      if C.ord '0' <= i && i <= C.ord '9' then False else True

strToIntList :: [Char] -> [Int]
strToIntList str = map (C.ord) str
