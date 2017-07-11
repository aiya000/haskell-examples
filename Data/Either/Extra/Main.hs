import Data.Either.Extra (maybeToEither)

xs :: [(Int, Int)]
xs = [ (1, 1)
     , (2, 2)
     ]

main :: IO ()
main = do
  print . maybeToEither "key is not found" $ lookup 3 xs
