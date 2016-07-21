data Nat = Zero | Succ Nat deriving Show

one = Succ Zero

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat i = Succ (int2nat $ i - 1)

ten = int2nat 10

main :: IO ()
main = do
  print $ Zero
  print $ one
  print $ nat2int one
  print $ ten
