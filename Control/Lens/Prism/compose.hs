import Control.Lens
import Data.Map.Lazy (Map)
import Data.Void (Void)
import qualified Data.Map.Lazy as M


xs :: Either Void (Int, Map Char Bool, String)
xs = Right ( 10
           , M.fromList [ ('a', False)
                        , ('b', True)
                        , ('c', False)
                        ]
           , "do your best"
           )

ys :: Maybe (Map Char Bool)
ys = xs ^? _Right . _2

zs :: [(Char, Bool)]
zs = let (Just ys') = ys
     in ys' ^. _iso

x :: Maybe Bool
x = lookupOf folded 'b' zs


y :: Maybe (Char, Bool)
y = xs ^? _Right . _2 . _iso . _head


_iso :: Ord k => Iso' (Map k v) [(k, v)]
_iso = iso M.toList M.fromList


z :: Maybe Char
z = z' ^? _Right . _Right . _2
  where
    z' :: Either String (Either Double (Int, Char, Bool))
    z' = Right $ Right (10, 'a', True)


main :: IO ()
main = do
  print z
  print x
  print y
