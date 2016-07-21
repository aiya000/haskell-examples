import Control.Monad.Takahashi
import Control.Lens

main :: IO ()
main = writeSlide "Layout.html" presentation

-- [ horizon
-- , vertical
-- ] :: [[Conents] -> Taka ()]
--
-- [ twinLeft, twinRight
-- , twinTop, twinBottom
-- ] :: [Contents -> Contents -> Taka ()]
--
-- [ horizonCont
-- , verticalCont
-- ] :: [[Contents] -> Contents]
--
-- [ twinLeftCont, twinRightCont
-- , twinTopCont, twinBottomCont
-- ] :: [Contents -> Contents -> Contents]
presentation :: Taka ()
presentation = do
  taka "Layoutについて"
  slideTitle .= "Layoutについて"
  horizon  -- :: [Contents] -> Taka ()
    [ parCont "par"
    , listCont ["a", "b", "c", "d"]
    ]
  vertical
    [ parCont "poo"
    , codeCont "xs = [x | x <- [1..], even]"
    ]
  horizon
    [ verticalCont
        [ parCont "Code"
        , codeCont "ys = [y | y <- [1..], odd]\nys' = take 10 ys"
        ]
    , listCont $ map show (take 10 [y | y <- [1..], odd y])
    ]
