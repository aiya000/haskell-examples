{-# LANGUAGE QuasiQuotes #-}

import Text.RawString.QQ (r)

x :: String
x = [r|ya|]

-- y :: Text
-- y = [r|hi|]

main :: IO ()
main = putStrLn x
