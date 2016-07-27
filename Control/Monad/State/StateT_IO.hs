import Control.Monad.State


-- wrapped IO {{{

ios1 :: StateT s IO Int
ios1 = StateT $ \s -> return (10, s)

runIOS1 :: IO ()
runIOS1 = do
  let io = runStateT ios1 ()
  io >>= print

-- }}}

-- runIO in StateT 1 {{{

ios2 :: StateT s IO String
ios2 = StateT $ \s -> do
  a <- getLine
  putStrLn $ "input: " ++ a
  return (a, s)

runIOS2 :: IO ()
runIOS2 = do
  let io = runStateT ios2 ()
  io >>= \x -> putStrLn ("state: " ++ show x)

-- }}}

-- runIO in StateT 2 {{{

ios3 :: StateT s IO ()
ios3 = lift $ print "liftIO"

runIOS3 :: IO ()
runIOS3 = runStateT ios3 10 >>= print

-- }}}

-- runIO in StateT 3 {{{

ios4 :: StateT String IO ()
ios4 = do
  a <- get
  lift $ print a

runIOS4 :: IO ()
runIOS4 = runStateT ios4 "message" >>= print

-- }}}


main :: IO ()
main = do
  runIOS1
  runIOS2
  runIOS3
  runIOS4
