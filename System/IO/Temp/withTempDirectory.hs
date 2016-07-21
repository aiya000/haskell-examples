import System.Directory ( getTemporaryDirectory )
import System.IO ( writeFile )
import System.IO.Temp ( withTempDirectory )

main :: IO ()
main = do
  tmpDir <- getTemporaryDirectory
  withTempDirectory tmpDir "identify" $ \dir -> do
    let tmpFile = dir ++ "/aho"
    putStrLn $ "dir is: " ++ dir
    writeFile tmpFile "afoo"
    readFile tmpFile >>= print
