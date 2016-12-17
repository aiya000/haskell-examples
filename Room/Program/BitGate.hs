import Control.Monad (forM_)

type Power       = Float
type Gate        = Power -> Power -> Power
type B           = Power
type PowerWeight = Power


ppGateTable :: Gate -> IO ()
ppGateTable gate = do
  let xs = gateTable gate
  forM_ xs $ \(x1, x2, result) -> do
    putStrLn $ "| " ++ show x1 ++ "\t| " ++ show x2 ++ "\t| " ++ show result ++ " |"
  putStrLn "- - - - - - - - - - - -"
  where
    gateTable :: Gate -> [(Power, Power, Power)]
    gateTable gate =
      let table = [ (0.0, 0.0)
                  , (1.0, 0.0)
                  , (0.0, 1.0)
                  , (1.0, 1.0)
                  ]
      in flip map table $ \(x1,x2) -> (x1, x2, gate x1 x2)

genericGate :: B -> PowerWeight -> PowerWeight -> Gate
genericGate b w1 w2 = \x1 x2 ->
  if x1*w1 + x2*w2 + b > 0.0 then 1.0
                             else 0.0

andGate :: Gate
andGate = genericGate (-0.9) 0.5 0.5

orGate :: Gate
orGate = genericGate (-0.1) 0.2 0.2


main :: IO ()
main = do
  putStrLn "- - AND"
  ppGateTable andGate
  putStrLn "- - OR"
  ppGateTable orGate
