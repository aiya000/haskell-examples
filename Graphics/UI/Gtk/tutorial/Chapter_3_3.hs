import Control.Monad
import Graphics.UI.Gtk

main :: IO ()
main = do
  initGUI
  window <- windowNew
  table  <- tableNew 1 7 True
  set window
    [ windowTitle          := "1週間やる蔵"
    , windowDefaultWidth   := 600
    , windowDefaultHeight  := 200
    , containerBorderWidth := 10
    , containerChild       := table
    ]
  forM_ [0..6] $ \i -> do
    button <- buttonNewWithLabel (show $ i + 1)
    tableAttachDefaults table button i (i + 1) 0 1
  onDestroy window mainQuit
  widgetShowAll window
  mainGUI
