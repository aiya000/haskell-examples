{-# LANGUAGE DataKinds #-}

-- X :: [*]
type X = '[Int, Char]

data AKind = TypeX | TypeY

-- Y :: [AKind]
type Y = '[TypeX, TypeY]

data ContainerKind a = Container a

-- Z :: ContainerKind *
type Z = Container Int

-- Z' :: ContainerKind AKind
type Z' = Container TypeX

main :: IO ()
main = return ()
