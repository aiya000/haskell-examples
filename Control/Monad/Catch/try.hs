import Control.Monad.Catch (try, SomeException)

foo :: IO Int
foo = fail "foo throw the exception"

main :: IO ()
main = do
  x <- try' foo
  case x of
    Right x -> putStr "succeed: " >> print x
    Left  y -> putStr "failed: "  >> print y
  where
    try' :: IO a -> IO (Either SomeException a)
    try' = try
