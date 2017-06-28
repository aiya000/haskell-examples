b is nothing or exist
> data StandBy a b = With a b | Lonely b
> 
> instance Functor (StandBy a) where
>   fmap f (a `With` b) = a `With` f b
>   fmap f (Lonely x) = Lonely $ f x
> 
> instance Applicative (StandBy a) where
>   pure = Lonely
>   (Lonely f) <*> x = fmap f x
>   (a `With` f) <*> (Lonely b) = a `With` f b
>   (a `With` f) <*> (_ `With` b) = a `With` f b

# The proof of Applicative laws for StandBy a

The identity law is
    pure id <*> v = v

The composition law is
    pure (.) <*> f <*> g <*> x
    = f <*> (g <*> x)

The homomorphism law is
    pure f <*> pure x
    = pure (f x)

The interchange law is
    f <*> pure x
    = pure ($ x) <*> f
- - - - -

The identity law ...
    pure id <*> x
    = fmap id x
    = x -- fmap id = id

- - - - -

## The composition law ...

If f and g is a pattern of 'Lonely _' -- (Lonely * Lonely * _)
    pure (.) <*> Lonely f' <*> Lonely g' <*> x
    = Lonely (f' .) <*> Lonely g' <*> x
    = Lonely (f' . g') <*> x
    = fmap (f' . g') x

    Lonely f' <*> (Lonely g' <*> x)
    = Lonely f' <*> fmap g' x
    = fmap f' (fmap g' x)
    = (fmap f' . fmap g') x -- a (b x) = (a . b) x
    = fmap (f' . g') x  -- fmap a . fmap b = fmap (a . b)

- - -

If f is a pattern of 'Lonely _', g is a pattern of '_ `With` _' -- (Lonely * With * _)
    pure (.) <*> Lonely f' <*> (a `With` g') <*> x
    = Lonely (f' .) <*> (a `With` g') <*> x
    = fmap (f' .) (a `With` g') <*> x
    = a `With` (f' . g') <*> x

    Lonely f' <*> ((a `With` g') <*> x)
    = Lonely f' <*> fmap g' x
    = fmap f' (fmap g' x)

- - -

If f is a pattern of '_ `With` _', g is a pattern of 'Lonely _',
and x is a pattern of 'Lonely _' -- (With * Lonely * Lonely)
    pure (.) <*> (a `With` f') <*> Lonely g' <*> Lonely x'
    = fmap (.) (a `With` f') <*> Lonely g' <*> Lonely x'
    = (a `With` (f' .)) <*> Lonely g' <*> Lonely x'
    = (a `With` (f' .)) <*> Lonely g' <*> Lonely x'
    = (a `With` (f' . g)) <*> Lonely x'
    = a `With` (f' . g) x'
    = a `With` f' (g x')  -- (a . b) c = a (b c)

    (a `With` f') <*> (Lonely g' <*> Lonely x')
    = (a `With` f') <*> (Lonely g' <*> Lonely x')
    = (a `With` f') <*> fmap g' (Lonely x')
    = (a `With` f') <*> (Lonely g' x')
    = a `With` f' (g' x')

- - -

If f is a pattern of '_ `With` _', g is a pattern of 'Lonely _',
and x is a pattern of '_ With _' -- (With * Lonely * With)
    pure (.) <*> (a `With` f') <*> Lonely g' <*> (a'' `With` x')
    = fmap (.) (a `With` f') <*> Lonely g' <*> (a'' `With` x')
    = (a `With` (f' .)) <*> Lonely g' <*> (a'' `With` x')
    = (a `With` (f' . g')) <*> (a'' `With` x')
    = a `With` (f' . g') x'
    = a `With` f' (g' x')  -- (a . b) c = a (b c)

    (a `With` f') <*> (Lonely g' <*> (a'' `With` x'))
    = (a `With` f') <*> (fmap g' (a'' `With` x'))
    = (a `With` f') <*> (a'' `With` g' x')
    = (a `With` f' (g' x'))

- - -

If f and g is a pattern of '_ `With` _',
and x is a pattern of 'Lonely _' -- (With * With * Lonely)
    pure (.) <*> (a `With` f') <*> (a' `With` g') <*> Lonely x'
    = (a `With` (f' .)) <*> (a' `With` g') <*> Lonely x'
    = a `With` (f' . g') x'
    = a `With` f' (g' x')  -- (a . b) c = a (b c)

    (a `With` f') <*> ((a' `With` g') <*> Lonely x')
    = (a `With` f') <*> (a' `With` g' x')
    = a `With` f' (g' x')

If f and g,
and x is a pattern of '_ `With` _' -- (With * With * With)
    pure (.) <*> (a `With` f') <*> (a' `With` g') <*> (a'' `With` x')
    = (a `With` (f' .)) <*> (a' `With` g') <*> (a'' `With` x')
    = (a `With` (f' . g')) <*> (a'' `With` x')
    = (a `With` (f' . g') x')
    = a `With` f' (g' x')

    (a `With` f') <*> ((a' `With` g') <*> (a'' `With` x'))
    = (a `With` f') <*> (a' `With` g' x')
    = a `With` f' (g' x')

- - - - -

## The homomorphism law ...
    Lonely f <*> Lonely x
    = fmap f (Lonely x)
    = Lonely (f x)

- - - - -

## The interchange law ...

If f is a pattern of 'Lonely _'
    Lonely f' <*> Lonely x
    = fmap f' (Lonely x)
    = Lonely (f' x)

    Lonely ($ x) <*> Lonely f'
    = fmap ($ x) (Lonely f')
    = Lonely (($ x) f')
    = Lonely (f' x)

If f is a pattern of '_ `With` _'
    (a `With` f') <*> Lonely x
    = a `With` f' x

    Lonely ($ x) <*> (a `With` f')
    = fmap ($ x) (a `With` f')
    = a `With` ($ x) f'
    = a `With` f' x

- - - - -

Q.E.D （倒した）
