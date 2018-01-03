{-# LANGUAGE MultiWayIf #-}

main :: IO ()
main = print $ if | 10 < 0    -> 'a'
                  | 10 < 6    -> 'b'
                  | 10 < 12   -> 'c'
                  | otherwise -> 'x'
-- {output}
-- 'c'
