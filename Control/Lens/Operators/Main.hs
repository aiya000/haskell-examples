import Control.Lens ((&), (?~), _2)

main :: IO ()
main = do
  let x = ('a', Just 10) & _2 ?~ 20
  print x
