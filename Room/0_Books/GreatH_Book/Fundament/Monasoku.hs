import Control.Monad((<=<))
-- I want to rename these.

{- monasoku -} --{{{

--- sakoutousei
e = 10
eexpr = (\x -> Just (x + 10))

exam0  = return e >>= eexpr
exam0' = eexpr e
isOk0  = exam0 == exam0'


--- ukoutousei
me = Just 10

exam1  = me >>= return :: Maybe Int
exam1' = me :: Maybe Int
isOk1  = exam1 == exam1'


--- Associativity
ce = Just 10
ceexpr = (\x -> Just (x + 10))
exam2  = ce >>= ceexpr
exam2' = ce >>= (\a -> ceexpr a)
isOk2  = exam2 == exam2'


--- More details Associativity
-- for normally function
--(.) :: (b -> c) -> (a -> b) -> (a -> c)
--f . g = (\x -> f (g x))

-- for Monadic function
--(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)
--f <=< g = (\x -> g x >>= f)

h a = (Just a+1)
i b = (Just b+2)
j c = (Just c+3)

-- ??? assoc = h <=< (i <=< j)

--}}}

