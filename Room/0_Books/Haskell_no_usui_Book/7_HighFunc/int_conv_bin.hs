import qualified Data.Char as C

main = putStrLn "Complie OK"


type Bit = Int

bin2int :: [Bit] -> Int
bin2int bits = allocWeight $ reverse bits
  where
    allocWeight = sum . map (\(w,b) -> w * b) . zip weights
    weights     = iterate (*2) 1


 -- {{{

binStrToInt :: String -> Int
binStrToInt = bin2int . reverse . map C.digitToInt

 -- }}}


int2bin :: Int -> [Bit]
int2bin int = make8 . reverse $ body int
  where
    body 0 = []
    body n = n `mod` 2 : body (n `div` 2)


make8 :: [Bit] -> [Bit]
make8 bits = reverse . take 8 $ (reverse bits) ++ repeat 0


encode :: String -> [Bit]
encode = concat . map (make8 . int2bin . C.ord)


 -- {{{

binToStr :: [Bit] -> String
binToStr = map C.intToDigit

 -- }}}


chop8 :: [Bit] -> [[Bit]]
chop8 []   = []
chop8 bits = let over  = take 8 bits
                 under = drop 8 bits
             in  over : chop8 under


decode :: [Bit] -> String
decode bits = let bitss = chop8 bits
              in  map (C.chr . bin2int) $ bitss
