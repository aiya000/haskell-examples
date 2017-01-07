import System.IO.Silently (capture_)

main :: IO ()
main = do
  ahoge <- capture_ $ putStrLn "ahoge"
  putStrLn ahoge
