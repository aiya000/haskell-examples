import Unsafe.Coerce
import qualified Data.Text.IO as TIO

newtype Foo = Foo { unFoo :: Int }


main :: IO ()
main = do
  print' $ unsafeCoerce $ 10
  print' $ unsafeCoerce $ 10.0
  print' $ unsafeCoerce $ "10"
  where
    print' :: Foo -> IO ()
    print' = print . unFoo
