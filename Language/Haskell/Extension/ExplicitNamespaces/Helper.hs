{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

module Helper
  ( type (-<|)
  , (-<|)
  ) where

type family (-<|) a b where
  x -<| _ = x

(-<|) :: a -> b -> a
(-<|) = const
