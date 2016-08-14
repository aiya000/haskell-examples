import Control.Monad.State (State, runState, get, put)
import qualified Data.Map as Map

type Count = Int
type CountTable = [(Char, Count)]

model :: CountTable
model = [('a', 5), ('b', 2)]

countDownTarget :: Char -> State CountTable Int
countDownTarget c = do
  table <- get
  case lookup c table of
       Nothing -> return 0
       Just n  -> do
         case replaceCount table c (n - 1) of
              Nothing     -> undefined
              Just table' -> do
                put table'
                return n
    where
      replaceCount :: CountTable -> Char -> Count -> Maybe CountTable
      replaceCount table c n = return $ Map.toList . Map.insert c n . Map.delete c . Map.fromList $ table

main :: IO ()
main = do
  let x = runState (countDownTarget 'a') model
  print x
