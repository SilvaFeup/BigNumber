import BigNumber

{-

Versão naive de Fibonacci.
Uso da Recursividade

-}

fibRec :: (Integral a) => a -> a

fibRec 0 = 0

fibRec 1 = 1

fibRec n = fibRec(n-1) + fibRec(n-2)


{-

Versão Programação Dinâmica de Fibonacci
Uso de uma lista Finita

-}
fibLista :: (Integral a) => a -> a
fibLista n = fibTab !! fromIntegral n
   where fibTab = map fib [0 .. n]
         fib 0 = 0
         fib 1 = 1
         fib n = fibTab !! fromIntegral(n-2) + fibTab !! fromIntegral(n-1)


{-
Fibonacci com geração de uma lista infinita de números de Fibonacci
-}
fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita n = listaFib !! (fromIntegral n) where
  listaFib = 0 : 1 : zipWith (+) listaFib (tail listaFib)

{-

Converter BigNumber para Int

-}
bnToInt::BigNumber -> Int
bnToInt bn = foldl1 (\x y -> 10*x+y) bn

{-

Versão naive Recursiva de Fibonacci recorrendo a BigNumber's

-}
fibRecBN::BigNumber->BigNumber
fibRecBN [] = []

fibRecBN [1] = [1]

fibRecBN n = somaBN (fibRecBN(subBN n  [1]))  (fibRecBN(subBN n [2]))


{-

Versão Programação Dinâmica de Fibonacci recorendo a operações entre BigNumber's


-}
fibListaBN :: BigNumber -> BigNumber
fibListaBN bn = fibTab !! (bnToInt bn)
   where fibTab = map fib [0 .. (bnToInt bn)]
         fib 0 = []
         fib 1 = [1]
         fib n = somaBN (fibTab !! fromIntegral(n-2))  (fibTab !! fromIntegral(n-1))

{-

Geração de Lista infinita (Fibonacci) de BigNumber's

-}
fibListaInfinitaBN :: BigNumber -> BigNumber
fibListaInfinitaBN n = listaFib !! (bnToInt n) where
  listaFib = [] : [1] : zipWith (somaBN) listaFib (tail listaFib)
