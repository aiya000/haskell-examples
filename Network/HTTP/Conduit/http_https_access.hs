{-# LANGUAGE OverloadedStrings #-}
import Control.Monad.IO.Class ( liftIO )
import Control.Monad.Trans.Resource ( runResourceT )
import Control.Monad.Trans.Resource.Internal ( MonadResource () )
import Network.HTTP.Client.Internal ( defaultManagerSettings )
import Data.Conduit ( ($$+-) )
import Network.Connection ( TLSSettings (TLSSettingsSimple) )
import Network.HTTP.Conduit ( newManager, parseUrl, http, urlEncodedBody, mkManagerSettings, responseBody )
import System.IO ( stdout )
import qualified Data.Conduit.Binary as CBinary

main :: IO ()
main = do
  runResourceT httpAccess
  runResourceT httpsAccess

httpAccess :: MonadResource m => m ()
httpAccess = do
  manager       <- liftIO $ newManager defaultManagerSettings
  request       <- liftIO $ parseUrl "http://google.co.jp"
  response      <- http request manager  -- Do request and Get its response
  responseBody response $$+- CBinary.sinkHandle stdout  -- Be careful for detail

httpsAccess :: MonadResource m => m ()
httpsAccess = do
  let settings    = mkManagerSettings (TLSSettingsSimple True False False) Nothing
  manager       <- liftIO $ newManager settings
  request       <- liftIO $ parseUrl "https://google.co.jp"
  response      <- http request manager
  responseBody response $$+- CBinary.sinkHandle stdout
