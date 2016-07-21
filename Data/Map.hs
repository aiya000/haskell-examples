-- See https://hackage.haskell.org/package/containers-0.5.7.1/docs/Data-Map.html
--     https://hackage.haskell.org/package/containers-0.5.7.1/docs/Data-Map-Strict.html
import Data.Map

main :: IO ()
main = do
  let xs = fromList [ (1, "homu")
                    , (2, "mado")
                    , (3, "homu")
                    ]
  print $ xs
  print $ xs ! 2
  print $ xs ! 3
