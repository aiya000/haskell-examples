data Skill = Magic | Sword deriving Show
data Foo = Foo
  { name :: String
  , skill :: Skill
  } deriving Show

foo :: Foo
foo = Foo
  { name  = "foo"
  , skill = Magic
  }

main :: IO ()
main = print foo
