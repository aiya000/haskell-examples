{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}

import Control.Eff (Eff, Member, run, (:>), SetMember)
import Control.Eff.Lift (Lift, lift, runLift)
import Control.Eff.Reader.Lazy (Reader, ask, runReader)
import Control.Eff.State.Lazy (State, get, put, runState)
import Control.Eff.Writer.Lazy (Writer, tell, runWriter, runMonoidWriter)
import Data.Void (Void)

-- effは文脈によって、必要に応じた効果のみを合成できたりする

type Logs = [String]


-- これはWriter Logs効果だけ使うやつ
writeOnly :: Member (Writer Logs) r => Eff r ()
writeOnly = tell ["nico"]

-- そしてこれはReader Logs効果とIOだけ使うやつじゃろ？
readAndShow :: (Member (Reader Logs) r, SetMember Lift (Lift IO) r) => Eff r ()
readAndShow = do
  logs <- ask
  lift $ mapM_ putStrLn (logs :: Logs)


-- それらを使うここで全ての効果を持っておけば、なんの変換も介さずに、自然な文脈としてそれらを使えるんじゃよ！
totalContext :: (Member (Writer Logs) r, Member (Reader Logs) r, SetMember Lift (Lift IO) r) => Eff r ()
totalContext = do
  writeOnly
  readAndShow


main :: IO ()
main = do
  x <- runLift
       . flip runReader []
       $ runWriter (++) ["nozomi", "eli"]
          (totalContext :: Eff (Writer Logs :> Reader Logs :> Lift IO :> Void) ())
  print x
