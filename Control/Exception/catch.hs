import Control.Exception


-- catch needs (function :: FooException e => e -> IO a) in second argument
printException :: SomeException -> IO ()
printException e = putStrLn $ "Exception: " ++ show e

main :: IO ()
main = putStrLn undefined `catch` printException
