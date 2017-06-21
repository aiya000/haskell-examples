{-# LANGUAGE TypeSynonymInstances #-}

type Hi = Int

class ToString a where
  show' :: a -> String


instance ToString Hi where
  show' _ = "(＞v＜)"


x :: Hi
x = 10

y :: Int
y = 10

main :: IO ()
main = do
  putStrLn $ show' x -- (＞v＜)
  putStrLn $ show' y -- (＞v＜)
