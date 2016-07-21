import Haste
import Haste.Prim
import Haste.Foreign

foreign import ccall "alert" falert :: JSString -> IO ()


dalert :: JSString -> IO ()
dalert = ffi $ toJSStr "(function(x) { alert(x); })"

alerts :: IO ()
alerts = do
  alert            "foo"  -- library's alert
  falert $ toJSStr "bar"  -- imported alert
  dalert $ toJSStr "baz"  -- defined alert

--callback = ffi $ toJSStr "


main :: IO ()
main = do
  alerts
