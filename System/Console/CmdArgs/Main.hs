{-# LANGUAGE DeriveDataTypeable #-}
import System.Console.CmdArgs

-- See http://kurokawh.blogspot.jp/2015/04/haskell-cmdargs.html

-- option data type must derive Data and Typeable
-- option data type needed DeriveDataTypeable pragma
data Options = Options
  { triname :: String
  , width   :: Float
  , height  :: Float
  } deriving (Show, Data, Typeable)

-- {option name} = default value
-- 'name' override option name ('triname' was overridden)
-- 'explicit' delete 'triname' option (but 'name' option remain)
options = Options
  { triname = "no name" &= name "name" &= explicit
  , width   = 0
  , height  = 0
  }
  &= summary "Triangle area size calculation"
  &= program "triangle"

main :: IO ()
main = do
  opt <- cmdArgs options
  let size = width opt * height opt / 2.0
  putStrLn $ "Triangle '" ++ triname opt ++ "' size is " ++ show size


-- <run example>
-- $ runghc basic_cmdargs.hs --name=taro --width=200 --height=300
-- $ runghc basic_cmdargs.hs --name taro --width 200 --height 300
