import Java

xs :: Java a JIntArray
xs = arrayFromList [1..5]

ys :: Java a JLongArray
ys = arrayFromList [1..5]

main :: IO ()
main = java $ do
  xs >>= io . print
  ys >>= io . print
-- {output}
-- JIntArray [I@33aa93c
-- JLongArray [J@1b005a0b
