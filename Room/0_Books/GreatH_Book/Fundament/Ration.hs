---
-- 2014-06-09
-- aiya000
---

import Data.Ratio

{- 分数を表す-} -- {{{

half = 1%2
full = half + half

-- 存在確立を表してみる
undefList = [3,5,7]
defList   = [(3,1%2), (5,1%4), (7,1%4)]

-- }}}

main = print full
