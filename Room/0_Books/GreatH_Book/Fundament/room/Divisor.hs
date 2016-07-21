
main = do
  max <- readLn
  putStrLn $ show $ divisorList  max
  putStrLn $ show $ divisorList' max


divisorList m = takeWhile (<=m) $ 2 : f [3,5..]
  where
    f (x:xs) = x : f [y| y<-xs, y `mod` x /= 0]

divisorList' m = takeWhile (<=m) $ 2 : f [3] [3,5..]
  where
    f (x:xs) ys = let (ps, qs) = span (< x^2) ys
                  in  ps ++ f (xs ++ ps) [z| z<-qs, z `mod` x /= 0]
