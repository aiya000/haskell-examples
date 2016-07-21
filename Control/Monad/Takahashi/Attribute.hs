import Control.Monad.Takahashi
import Control.Lens

main :: IO ()
main = writeSlide "Attribute.html" presentation

-- See http://hackage.haskell.org/package/takahashi-0.2.0.2/docs/Control-Monad-Takahashi-Slide.html#t:SlideOption
presentation :: Taka ()
presentation = do
  taka "文字色とかとか"
  contentsOption.fontColor .= Just (Color 0 100 50)
  contentsOption.bgColor   .= Just (Color 255 200 200)
  vertical
    [ parCont "foo"
    , parCont "bar"
    ]
