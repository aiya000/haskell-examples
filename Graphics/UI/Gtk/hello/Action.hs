import Graphics.UI.Gtk

main :: IO ()
main = do
  initGUI
  window <- windowNew
  button <- buttonNew
  set button [ buttonLabel := "Hello" ]
  onClicked button $ set button [ buttonLabel := "World!!" ]
  set window
    [ windowDefaultWidth   := 200
    , windowDefaultHeight  := 200
    , containerChild       := button
    , containerBorderWidth := 10
    ]
  onDestroy window mainQuit
  widgetShowAll window
  mainGUI
