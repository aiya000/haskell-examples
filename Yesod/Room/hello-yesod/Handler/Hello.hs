module Handler.Hello where

import Import

getHelloR :: Handler Html
getHelloR = defaultLayout $(widgetFile "hello")
