import GHC.Stack

main :: IO ()
main = do
  bar
  pure ()

bar :: IO ()
bar = foo

foo :: HasCallStack => IO ()
foo = currentCallStack >>= mapM_ putStrLn
-- {output}
-- Main.main (GHC/Stack/Main.hs:(4,1)-(6,9))
-- Main.bar (GHC/Stack/Main.hs:9:1-9)
-- Main.foo (GHC/Stack/Main.hs:12:1-41)
