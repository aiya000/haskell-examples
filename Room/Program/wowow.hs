
--code = "wwowo?wo?ow??qqoww?"
-- wwowo?wo?
-- ?wwoqq??qo

--code = "???w"
-- ??
-- w?


type Code = [Char]
code = "wwowo?wooow??wowow?" :: Code
--      wwowo?wo?
--      ?wowow??wo

wrapCode :: (Code,Code)
wrapCode =
  let halfLen = length code `div` 2
      halfL = take halfLen code
      --halfR = take (length code - halfLen) $ reverse code
      halfR = take halfLen $ reverse code
  in  (halfL, halfR)

judgeSym (la @ (cl:csL), ra @ (cr:csR))
  | cl == [] || cr == [] = True
  | la == ra  = True
  | cl == cr  = judgeSym (csL,csR)
  | cl == '?' || cr == '?'  = judgeSym (csL,csR)
  | cl /= cr  = False
  | otherwise = True


main = do
  let code = wrapCode
  putStrLn $ show $ judgeSym code
