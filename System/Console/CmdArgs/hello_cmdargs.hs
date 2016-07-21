{-# LANGUAGE DeriveDataTypeable #-}
import System.Console.CmdArgs

data Hello = Hello { hello :: String } deriving (Show, Data, Typeable)

hey = Hello { hello = def &= help "Hello element value" &= opt "without value(hello)" }
        &= summary "Hello, CmdArgs !!"

main = cmdArgs hey >>= print

-- <run example>
-- $ runghc hello_cmdargs.hs --hello=world
-- $ runghc hello_cmdargs.hs --hello
-- $ stack runghc hello_cmdargs.hs -- --hello
