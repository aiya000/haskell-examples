import System.Posix.Env (getEnv, getEnvDefault)

main :: IO ()
main = do
  x <- getEnv "HOME"
  y <- getEnvDefault "AHOGE" "aho"
  print x
  print y
