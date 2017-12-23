import GHC.Int (Int32)
import Java

-- In eta 0.0.9b3

-- | A context
m :: Java a Int
m = do
  io $ putStrLn "m is evaluated"
  return 10

main :: IO ()
main = java $ do
  -- pureJava is equivalent to unsafePerformIO.
  -- ```
  -- pureJava :: (forall c. Java c a) -> a
  -- pureJava action = unsafePerformIO (java action)
  -- ```
  --
  -- `pureJavaWith :: (Class c) => c -> Java c a -> a`
  -- is mostly same as it.
  -- pureJava is seriously unsafed
  let x = pureJava $ m
  io $ print x
  -- any instance to both JArray and JavaConverter,
  -- (
  -- e.g. JIntArray is
  -- ```
  -- instance JArray Int JIntArray
  -- instance JavaConverter [Int32] JIntArray
  -- ```
  -- )
  -- that fromJava (and toJava) may use pureJavaWith or the equivalent.
  -- (e.g. JIntArray's fromJava uses pureJavaWith)
  -- ```
  -- toJava   :: JavaConverter a b => a -> b
  -- fromJava :: JavaConverter a b => b -> a
  -- ```
  -- (but that implementation maybe safe :D)
  let xs = toJava ([1..10] :: [Int32]) :: JIntArray
  io $ print xs
-- {output}
-- m is evaluated
-- 10
-- JIntArray [I@88a8218
