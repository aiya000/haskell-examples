-- See http://tokiwoousaka.github.io/takahashi/contents/20150213takahashi.html
import Control.Monad.Takahashi
import Control.Lens

main :: IO ()
main = writeSlide "Basic.html" presentation

presentation :: Taka ()
presentation = do
  taka "タイトルとか"
  par "段落\nmain :: IO ()\nmain = print 10"
  code "コード" "main :: IO ()\nmain = putStrLn \"超ベンリ\""
  list ["Functor", "Applicative", "☞Monad"]
  img HStretch "./SS.png"
  --
  slideTitle .= "これタイトル"  -- (.=) is Lensの代入演算子
  par "ここのページにタイトルがある"
  par "ここは…？"
  slideTitle .= ""
  par "そして無くなる。"
