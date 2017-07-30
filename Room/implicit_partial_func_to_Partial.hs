import Control.Monad.Plus (Partial(..))
import Control.Spoon (spoon)


data Person = John | Cathy
  deriving (Show)


-- | A partial function (but partially property cannot be shown in the type)
shy :: Person -> String
shy John = "hi :D"

-- | He is shy, but he represents it in the type.
shy' :: Partial Person String
shy' = Partial $ spoon . shy


infixr 1 $:

($:) :: Partial a b -> a -> Maybe b
(Partial f) $: x = f x


main :: IO ()
main = do
  print $ shy' $: John  -- He talked with John delightfully
  print $ shy' $: Cathy -- He didn't talk with Cathy
  print $ shy Cathy -- He angried on suddenly !!
