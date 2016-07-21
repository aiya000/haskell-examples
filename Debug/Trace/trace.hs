import Debug.Trace (trace)

add :: Int -> Int -> Int
add x y =
  let a = x + y
  in  trace (show x ++ " + " ++ show y ++ " = " ++ show a) a


main :: IO ()
main = print $ add 10 20
