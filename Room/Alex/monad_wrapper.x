{
module Main where
}

%wrapper "monad"

tokens :-
  \[ { push LoopBegin }
  \] { push LoopEnd   }
  \< { push MoveNext  }
  \> { push MovePrev  }
  \. { push Output    }
  \, { push Input     }
  \+ { push Increment }
  \- { push Decrement }

{
push :: Token -> AlexAction [Token]
push x = \_ _ -> do
  xs <- alexMonadScan
  pure (x:xs)

alexEOF :: Alex [Token]
alexEOF = return [Eof]

data Token = LoopBegin
           | LoopEnd
           | MoveNext
           | MovePrev
           | Output
           | Input
           | Increment
           | Decrement
           | Eof
  deriving (Show)

main :: IO ()
main = do
  print . runAlex "+" $ alexMonadScan 
  print . runAlex "[]<>.,+" $ alexMonadScan 
  print . runAlex "+++++[>+<-]" $ alexMonadScan 
  print . runAlex "hi" $ alexMonadScan 
}
