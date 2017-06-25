{-# LANGUAGE TemplateHaskell #-}

module Hamburger.TH where

import Language.Haskell.TH (Type(..), Name, mkName, Exp(..), DecsQ, Dec(..), Clause(..), Pat(..), Body(..), Lit(..))

type TypeName = String

type Topping4 = (TypeName, TypeName, TypeName, TypeName)


topping4s :: [Topping4]
topping4s = [(w, x, y, z) | w <- toppings, x <- toppings, y <- toppings, z <- toppings]
  where
    toppings :: [TypeName]
    toppings = ["Space", "Cheese", "Tomato", "Meet", "Ushi"]

-- | Make a AST of @Type@ is like "(HamburgerC Space Cheese Tomato Meet)"
hamburgerC :: Topping4 -> Type
hamburgerC (w, x, y, z) = ParensT (ConT (mkName "HamburgerC") 
                            `AppT` ConT (mkName w)
                            `AppT` ConT (mkName x)
                            `AppT` ConT (mkName y)
                            `AppT` ConT (mkName z))

-- |
-- Make a AST of @Exp@ is like "Concrete SSpace SCheese STomato SMeet"
-- (@Topping4@ elements are added "S" prefix for @STopping@).
concrete :: Topping4 -> Exp
concrete (w, x, y, z) = ConE (mkName "Concrete")
                 `AppE` ConE (mkName $ "S" ++ w)
                 `AppE` ConE (mkName $ "S" ++ x)
                 `AppE` ConE (mkName $ "S" ++ y)
                 `AppE` ConE (mkName $ "S" ++ z)


-- | Define @Singleton@ instances and @Show@ instances for any pattern of @topping4@
defineInstances :: DecsQ
defineInstances = do
  let singletonInstances = map defineSingletonInstance topping4s
      showInstances      = map defineShowInstance topping4s
  return $ singletonInstances ++ showInstances
  where
    defineSingletonInstance :: Topping4 -> Dec
    defineSingletonInstance t4@(w, x, y, z) =
      InstanceD Nothing []
        (ConT (mkName "Singleton") `AppT` hamburgerC t4)
        [
          FunD (mkName "sing") [Clause [] (NormalB $ concrete t4) []]
        ]

    defineShowInstance :: Topping4 -> Dec
    defineShowInstance t4@(w, x, y, z) =
      InstanceD Nothing []
        (ConT (mkName "Show") `AppT` ParensT (ConT (mkName "SHamburger") `AppT` hamburgerC t4))
        [
          FunD (mkName "show") [Clause [WildP] (NormalB $
              (LitE . StringL $ "SHamburger (" ++ w ++ " " ++ x ++ " " ++ y ++ " " ++ z ++ ")")
          ) []]
        ]
