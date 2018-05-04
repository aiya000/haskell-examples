{-# LANGUAGE CPP #-}

currentFileLine :: String
currentFileLine = __FILE__ ++ ":L" ++ show __LINE__

main :: IO ()
main = putStrLn currentFileLine
-- {output}
-- /path/Language/Haskell/Extension/CPP/__FILE__.hs:L4
