import Idris.ElabDecls (elabPrims)
import Idris.Main (runMain)

main :: IO ()
main = runMain elabPrims
