{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}

data KindDom = DomA | DomB
data KindCod = CodA | CodB

type family Func (a :: KindDom) :: KindCod
type instance Func DomA = CodA
type instance Func DomB = CodB


main :: IO ()
main = return ()
