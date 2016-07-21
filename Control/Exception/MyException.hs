{-# LANGUAGE ScopedTypeVariables #-}
import Control.Exception

data Status      = Fine deriving (Show)
data MyException = MyException Status
instance Exception MyException
instance Show MyException where
  show (MyException s) = "ahoge: MyException (" ++ (show s) ++ ")"


main :: IO ()
main = do
  throw (MyException Fine) `catch` \(e :: MyException) -> print e
