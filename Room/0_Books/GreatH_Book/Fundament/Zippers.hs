

type ListZippper a = ([a], [a])
zList = ([], [1..5])

listNext :: ListZippper a -> ListZippper a
listNext (ns, p:ps) = (p:ns, ps)

listPrev :: ListZippper a -> ListZippper a
listPrev (n:ns, ps) = (ns, n:ps)

main = print $ listNext zList
