{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}

type family Func a :: * where
  Func Int  = Int
  Func Char = Int

type X = Func Int


main :: IO ()
main = return ()
