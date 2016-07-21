import Control.Monad.State

type Message = String
data Person  = Chino | Rize | Cocoa | Syaro | Chiya | Nobody deriving Show

rabitHouse :: State Person Message
rabitHouse = state $ \s -> ("", Nobody)

chino :: Message -> State Person Message
chino x = state $ \s -> (x ++ "ごち", Chino)

rize :: Message -> State Person Message
rize x = state $ \s -> (x ++ "うさ", Rize)

cocoa :: Message -> State Person Message
cocoa x = state $ \s -> (x ++ "うどん！", Cocoa)

syaro :: Message -> State Person Message
syaro x = state $ \s -> (x ++ "ワールド！", Syaro)

chiya :: Message -> State Person Message
chiya x = state $ \s -> (x ++ "祝福の風", Chiya)

main :: IO ()
main = putStrLn $ evalState
  (rabitHouse >>= chino >>= rize >>= cocoa >>= syaro >>= chiya) Nobody
