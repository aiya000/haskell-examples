import System.Directory

main :: IO ()
main = do
  b <- doesFileExist "aho"
  createDirectoryIfMissing False "baka"
