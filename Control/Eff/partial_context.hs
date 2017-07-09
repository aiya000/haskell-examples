{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}

import Control.Eff (Eff, Member, run, (:>), SetMember)
import Control.Eff.Lift (Lift, lift, runLift)
import Control.Eff.Reader.Lazy (Reader, ask, runReader)
import Control.Eff.State.Lazy (State, get, put, runState)
import Control.Eff.Writer.Lazy (Writer, tell, runWriter, runMonoidWriter)
import Data.Void (Void)

type Logs = [String]


-- Writer Logs, Reader Logs, Lift IOを使う文脈があるじゃろ
totalContext :: (Member (Writer Logs) r, Member (Reader Logs) r, SetMember Lift (Lift IO) r) => Eff r ()
totalContext = do
  logs <- ask
  tell (logs :: Logs)
  lift . putStrLn $ show logs ++ " was added"

-- そのうちReader Logs, Lift IOのみを使う文脈がある
--partialContext :: forall s. (Member (Reader Logs) s, SetMember Lift (Lift IO) s) => Eff s ()
partialContext :: Eff (Reader Logs :> Lift IO :> Void) ()
partialContext = do
  x <- runWriter' totalContext
  lift $ print x
  where
    -- そうすると、なんとWriter Logs効果だけを消費することができるのじゃ！
    --TODO: totalContextを単相化する必要があるので、それを含むpartialContextを多相化できない。どうすればいい？
    runWriter' :: Eff (Writer Logs :> s) () -> Eff s (Logs, ())
    runWriter' = runWriter (++) ["nico", "maki"]


main :: IO ()
main = do
  x <- runLift $ runReader partialContext ["nozomi", "eli"]
  print x
-- output
-- ["nozomi","eli"] was added
-- (["nozomi","eli","nico","maki"],())
-- ()
