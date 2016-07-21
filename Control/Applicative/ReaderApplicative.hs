import Control.Applicative ((<$>), (<*>))

f = (+)
g = (*2)
h = (+20)

rFunc   = \x -> f (g x) (h x)
rFunc'  = \x -> f <$> g <*> h $ x


f' = \x y z -> x + y + z
i  = (^3)

rFunc1  = \x -> f' (g x) (h x) (i x)
rFunc1' = \x -> f' <$> g <*> h <*> i $ x

main = do
  print $ rFunc  10 == rFunc'  10
  print $ rFunc1 20 == rFunc1' 20
