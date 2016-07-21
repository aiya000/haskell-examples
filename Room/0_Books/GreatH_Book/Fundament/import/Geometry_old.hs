-- このファイル(モジュール)をインポートするには、同じ階層にいなければならない。
-- 今回の場合はモジュールの階層化がなされていないからである。

module Geometry (
  sphereVolume,
  sphereArea,
  cubeVolume,
  cubeArea,
  cuboidVolume,
  cuboidArea
) where

sphereVolume :: Float -> Float
sphereVolume radius = (4.0/3.0) * pi * (radius ^ 3)

sphereArea :: Float -> Float
sphereArea radius = 4 * pi * (radius ^ 2)

cubeVolume :: Float -> Float
cubeVolume side = cuboidVolume side side side

cubeArea :: Float -> Float
cubeArea side = cuboidArea side side side

cuboidVolume :: Float -> Float -> Float -> Float
cuboidVolume a b c = rectArea a b * c

cuboidArea :: Float -> Float -> Float -> Float
cuboidArea a b c = rectArea a b * 2 + rectArea a b * 2 + rectArea a b * 2

-- この関数はエクスポートされていないので外部から参照されない
rectArea :: Float -> Float -> Float
rectArea a b = a * b
