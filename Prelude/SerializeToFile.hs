import Data.Map
import qualified Data.Map as Map
import Control.Exception (finally)
import System.Directory (removeFile)

type Config = Map String String


configFile :: FilePath
configFile = "config"

saveConfig :: Config -> IO ()
saveConfig config = writeFile configFile $ show config

loadConfig :: IO Config
loadConfig = read' <$> readFile configFile
  where
    read' :: String -> Config
    read' = read

main :: IO ()
main = serialize `finally` removeFile configFile

serialize :: IO ()
serialize = do
  let config = Map.fromList [ ("thing", "My letter was shown in 6th NOeRADiO !!")
                            , ("feel",  "So Happy !! So Good !! Thanks :D !!")
                            ]
  saveConfig config
  config' <- loadConfig
  print config'
