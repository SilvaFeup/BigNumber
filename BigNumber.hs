module BigNumber where

import Data.Char


type BigNumber = [Int] -- 2.1

--2.2


{-

Função Scanner : Conversão de String para BigNumber

-}
scanner :: String -> BigNumber
scanner s = if isDigit(s !! 0) then map digitToInt s  else replaceNeg(map digitToInt (tail s))


{-

Função replaceNeg : Troca de Sinal de BigNumber

-}
replaceNeg :: [Int] -> [Int]
replaceNeg [] = []
replaceNeg (x:xs) = ((-x):xs)


{-

Função output : Conversão de BigNumber Para String

-}
output :: BigNumber -> String
output (x:xs) =  concat (map show (x:xs))

{-

função negNumber : Verificação de número negativo Para Operações com BigNumber Invertido.

-}
negNumber:: BigNumber -> Bool
negNumber bn = if bn == []
  then  False
  else if (bn !! (length bn - 1) < 0)
    then True
  else False


{-

função filterZeros :  Remover zeros á esquerda

-}
filterZeros :: BigNumber -> BigNumber
filterZeros bn  = if (head(bn) == 0)
  then dropWhile (== 0) bn
  else bn



{-

função safeDivBN : Divisão entre BigNumber's com reurso ao Monad Maybe para divisão com [0]

-}
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN bn1 bn2 = if (bn2 == [0])
  then Nothing
  else Just  (sol , resto sol bn1 bn2 ) where
    sol = divBn' [1] bn1 bn2


{-

Função SubBN : Função de Subtração entre BigNumber's com recurso à propriedades da subtração e da soma

-}
subBN::BigNumber->BigNumber->BigNumber
subBN x y = somaBN x (replaceNeg y)

{-

Função mulBN : Função de Multiplacação entre BigNumber´s com recurso ao algoritmo de long Multiplacation

-}
mulBN::BigNumber ->BigNumber->BigNumber
mulBN x y = if ( ( (x !! 0) > 0 && (y !! 0) > 0 ) || ( (x !! 0) < 0 && (y !! 0) < 0 ) )
  then filterZeros ( reverse (mulBn'  0 0 (reverse x) (reverse y) ) )
  else if ( (x !! 0) < 0 && (y !! 0) > 0 )
  then replaceNeg ( filterZeros  (reverse (mulBn'  0 0 (reverse (replaceNeg x)) (reverse y) ) ) )
  else replaceNeg ( filterZeros   (reverse (mulBn'  0 0 (reverse x) (reverse (replaceNeg y) ) ) ) )


{-

Função divBN : Função de divisão entre BigNumber's recorrendo a funções auxiliares para calcular o quociente e o resto.

-}
divBN::BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN bn1 bn2 = (sol , resto sol bn1 bn2 ) where
  sol = divBn' [1] bn1 bn2


{-

Função divBN' : Calculo do quociente utilizando a estratégia m * q <= l , qi = 1

-}
divBn'::BigNumber -> BigNumber -> BigNumber -> BigNumber
divBn' d bn1 bn2 = if  (subBN (mulBN bn2 d) bn1  == [])
  then d
  else if (subBN (mulBN bn2 d) bn1 !! 0 > 0)
  then subBN d [1]
  else divBn' (somaBN d [1]) bn1 bn2


{-

Função resto : Cálculo do Resto da divisão

-}
resto::BigNumber -> BigNumber -> BigNumber -> BigNumber
resto sol bn1 bn2 = if (mulBN sol bn2 == bn1)
  then []
  else subBN bn1 (mulBN sol bn2)


{-

Função mulBN' : aplicação do algoritmo long Multiplacation com carrying

-}
mulBn'::Int ->Int ->BigNumber -> BigNumber->BigNumber
mulBn' 0 0 x []  = []
mulBn' 0 0 [] y = []
mulBn' carry zeros (x:[]) (y:[]) = [(r `rem` 10),(r `div` 10)] where
  r = x * y + carry

mulBn' carry zeros (x:[]) (y:ys) =  (take zeros (cycle [0]) ) ++ ( ( (x*y)`rem` 10 + carry) : (mulBn' ((x*y) `quot` 10) 0 [x] ys) )

mulBn' carry zeros (x:xs) (y:[]) =  (take zeros (cycle [0]) ) ++  ( ( (x*y)`rem` 10 + carry) : (mulBn' ( (x*y) `quot` 10) 0 xs [y]) )

mulBn' 0 zeros (x:xs) (y:ys) = if length(x:xs) > length(y:ys)
  then mulBnGreater (mulBn' 0 zeros (x:xs) [y] ) (mulBn' 0 (zeros + 1) (x:xs) ys )
  else mulBnGreater (mulBn' 0 zeros [x] (y:ys) ) (mulBn' 0 (zeros + 1) xs (y:ys) )

{-

função mulBnYgreater : função auxiliar de Multiplacação para condição de length de Y(BigNumber) maior que length de X(BigNumber)

-}
mulBnGreater::BigNumber -> BigNumber ->BigNumber
mulBnGreater bn1 bn2 = reverse (somaBN (filterZeros ( reverse bn1 ) ) (filterZeros (reverse bn2 ) ) )




{-

função absBigNumber : valor absoluto de BigNumber

-}
absBigNumber::BigNumber->BigNumber
absBigNumber bn = if (bn !! 0 < 0)
  then replaceNeg bn
  else bn

{-

função greaterBn : retorna valor lógico sobre a superioridade do primeiro BigNumber sobre o segundo BigNumber
-}
greaterBn::BigNumber->BigNumber->Bool
greaterBn x [] = True
greaterBn [] y = False
greaterBn (x:xs) (y:ys) = if (abs x  == abs y)
  then greaterBn xs ys
  else if abs x > abs y
    then True
  else False


{-

função somaBN : Verificação de corner cases para efetuar a soma entre dois BigNumber's

-}
somaBN::BigNumber->BigNumber->BigNumber

somaBN x y = if ( x == [] || y == [] || (x !! 0 > 0 && y !! 0 > 0) )
  then filterZeros ( reverse ( somaBn' 0 ( reverse x ) ( reverse y ) ) )

  else if (  (x !! 0 < 0 && y !! 0 < 0)  )
  then replaceNeg (filterZeros ( reverse ( somaBn' 0 ( reverse ( replaceNeg x) ) ( reverse (replaceNeg y) ) ) ) )

  else if ( (length x > length y)  && (x !! 0 < 0) )
  then replaceNeg ( filterZeros ( reverse ( somaBnNeg False ( reverse ( replaceNeg x) ) ( reverse y  ) ) ) )

  else if ( (length x > length y)  && (y !! 0 < 0) )
  then filterZeros ( reverse ( somaBnNeg False ( reverse x ) ( reverse (replaceNeg y)  ) ) )

  else if ( (length y > length x)  && (x !! 0 < 0) )
  then filterZeros ( reverse ( somaBnNeg False ( reverse y ) ( reverse (replaceNeg x)  ) ) )

  else if ( (length y > length x)  && (y !! 0 < 0) )
  then  replaceNeg ( filterZeros ( reverse ( somaBnNeg False ( reverse ( replaceNeg y) ) ( reverse x  ) ) ) )

  else if ( (length x == length y)  && (greaterBn x y ) && (x !! 0 < 0))
  then replaceNeg ( filterZeros ( reverse ( somaBnNeg False ( reverse ( replaceNeg x) ) ( reverse y  ) ) ) )

  else if ( (length x == length y)  && (greaterBn x y ) && (y !! 0 < 0))
  then filterZeros ( reverse ( somaBnNeg False ( reverse x ) ( reverse (replaceNeg y)  ) ) )

  else if ( (length x == length y)  && (greaterBn y x ) && (y !! 0 < 0) )
  then replaceNeg ( filterZeros ( reverse ( somaBnNeg False ( reverse ( replaceNeg y) ) ( reverse x  ) ) ) )

  else if ( (length x == length y)  && (greaterBn y x ) && (x !! 0 < 0) )
  then filterZeros ( reverse ( somaBnNeg False ( reverse y ) ( reverse (replaceNeg x)  ) ) )

  else if (absBigNumber x == absBigNumber y)
    then []

  else []



{-

função somaBnNeg : efetuar a soma de um BigNumber positivo e um BigNumber negativo

-}
somaBnNeg::Bool->BigNumber->BigNumber -> BigNumber
somaBnNeg False (x:[]) (y:[]) =   [x-y]


somaBnNeg True (x:[]) (y:[]) = [ (x - 1) - y ]

somaBnNeg False x [] =   x

somaBnNeg True (x:xs) [] = [ x - 1 ]

somaBnNeg False (x:xs) (y:ys) = if (y == 0)
  then x: (somaBnNeg False xs ys)
  else if (x `quot` y) > 0
  then (x-y):(somaBnNeg False xs ys)
  else ( (10+x) - y ):(somaBnNeg True xs ys)

somaBnNeg True (x:xs) (y:ys) = if (y == 0)
  then (x-1):(somaBnNeg False xs ys)
  else if ( ( x - 1 ) `quot` y) > 0
  then ( ( x - 1 ) - y ):(somaBnNeg False xs ys)
  else ( (9+x) - y ):(somaBnNeg True xs ys)



{-

função somaBN' : efetuar a soma com carrying entre dois números negativos e dois números positivos

-}
somaBn'::Int->BigNumber->BigNumber->BigNumber
somaBn' 0 x [] = x
somaBn' 0 [] y = y
somaBn' carry (x:[]) (y:[]) = if ((r `quot` 10) == 0)
  then [(r `rem` 10)]
  else [(r `rem` 10),(r `div` 10)] where
    r = x + y + carry

somaBn' carry (x:xs) [] =  (somaBn' (r `quot` 10) ((r `rem` 10):xs) []) where
  r = x + carry

somaBn' carry [] (y:ys) = (somaBn' (r `quot` 10) ((r `rem` 10):ys) []) where
  r = y + carry

somaBn' carry (x:xs) (y:ys) =  ((r `rem` 10) : (somaBn' (r `quot` 10) xs ys)) where
  r = x + y + carry
