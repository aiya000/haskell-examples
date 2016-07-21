-- NonDet is 'non determinated'
-- type of multi value function
type NonDet i o = i -> [o]

sqrts :: NonDet Float Float
sqrts x = [sqrt x, - (sqrt x)]


-- newtype
newtype NonDet' i o = NonDet' { runNonDet' :: i -> [o] }

sqrts' :: NonDet' Float Float
sqrts' = NonDet' $ \x -> [sqrt x, - (sqrt x)]

runSqrts' :: Float -> [Float]
runSqrts' x = runNonDet' sqrts' x
