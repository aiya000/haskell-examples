import Graphics.UI.Gtk
import Data.IORef

main :: IO ()
main = do
  initGUI
  window <- windowNew
  button <- buttonNewWithLabel "Click"
  set window
    [ windowTitle          := "Hello Dialog"
    , windowDefaultWidth   := 200
    , windowDefaultHeight  := 200
    , containerChild       := button
    , containerBorderWidth := 10
    ]
  counter <- newIORef 1
  onClicked button $ do
    count  <- readIORef counter
    writeIORef counter (count + 1)
    dialog <- messageDialogNew (Just window) [] MessageInfo ButtonsOk (show count)
    dialogRun dialog
    widgetDestroy dialog
  onDestroy window mainQuit
  widgetShowAll window
  mainGUI
