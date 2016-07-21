module Handler.ControlA where
import Import

getControlAR :: Handler Html
getControlAR = do
  let values = [1..10]    :: [Int]
      foo    = Just "foo" :: Maybe String
      bar    = Nothing    :: Maybe String
      aho    = Right "aho" :: Either String String
  defaultLayout $(widgetFile "controlA")

widget :: Widget
widget = $(widgetFile "widget")
