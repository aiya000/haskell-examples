data Bar a = Bar
  { foo :: a
  } deriving (Show, Eq)

instance Monad Bar where
  return = Bar
  (Bar x) >>= f = f x

instance Applicative Bar where
  pure = return
  (Bar f) <*> x = x >>= return . f

instance Functor Bar where
  fmap f x = (Bar f) <*> x

-- simple easily check
monadCheck :: Bar Int -> Bool
monadCheck m =
  let simpleF = return . show . (+1)
      simpleG = return . (+1) . read
      laws    =
        [ (return 10 >>= simpleF) == simpleF 10
        , (m >>= return) == m
        , ((m >>= simpleF) >>= simpleG) == (m >>= (\x -> simpleF x >>= simpleG))
        ]
  in foldl (&&) True laws

main :: IO ()
main = print $ monadCheck (Bar 10)
