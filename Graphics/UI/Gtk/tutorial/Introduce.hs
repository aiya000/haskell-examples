-- incompleted file
import Graphics.UI.Gtk

-- set and get function
main :: IO ()
main = do
  window <- windowNew
  set window [ windowTitle := "Title" ]
  title  <- get window windowTitle  -- ??
  print title
