import Graphics.UI.Gtk

main :: IO ()
main = do
  initGUI
  window <- windowNew
  label  <- labelNewWithMnemonic "Hello,world!!"
  set window
    [ windowDefaultWidth   := 200
    , windowDefaultHeight  := 200
    , containerChild       := label
    , containerBorderWidth := 10
    ]
  onDestroy window mainQuit
  widgetShowAll window
  mainGUI
