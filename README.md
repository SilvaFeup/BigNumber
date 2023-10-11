# Projeto de Haskell

## João Silva : up201906478 
## António Lima : up202003386

## Casos de teste

Não existe nenhum ficheiro com objetivo de testar o os ficheiros Fib.hs e BigNumber.hs
O procedimento de testes do programa foi testar a partir da consola com vários corner cases que poderiam causar problemas nas funções.


## Descrição de funções

### Fib.hs

fibRec

- Versão Naive de Geração de números de Fibonacci, Uso da Recursividade (Soma dos dois elementos anteriores).

fibLista

- Cálculo de números de Fibonacci recorrendo a programção de Dinâmica, uso de lista finita para guardar valores calculados anteriormente.

fibListaInfinita

- Cálculo de números de Fibonacci recorrendo à geração de números de fibonacci numa lista infinita, uso de zipWith(+) da cauda da lista com a própria lista para gerar uma lista infinita.

bnToInt

- função auxiliar para conversão de BigNumber para Inteiro, função usada para contornar a função de indexação.

fibRecBN

- cálculo de BigNumbers de fibonacci recursivamente recorrendo a operações de aritmética entre BigNumber's.

fibListaBN

- cálculo de BigNumbers de fibonacci (programação dinâmica) recorrendo a uma lista finita que guarda os BigNumber's anteriormente calculados.

fibListaInfinitaBN

- Geração de uma lista infinita de BigNumber's de fibonacci com recurso a zipWith (somaBN) entre a lista e própria cauda da lista.


### BigNumber.hs


Função Scanner

- Conversão de String para BigNumber

Função replaceNeg 

- Troca de Sinal de BigNumber

Função output 

- Conversão de BigNumber Para String

função negNumber 

- Verificação de número negativo Para Operações com BigNumber Invertido.

função filterZeros 

- Remover zeros á esquerda

função safeDivBN 

- Divisão entre BigNumber's com reurso ao Monad Maybe para divisão com [0]

Função SubBN 

- Função de Subtração entre BigNumber's com recurso à propriedades da subtração e da soma

Função mulBN 

- Função de Multiplacação entre BigNumber´s com recurso ao algoritmo de long Multiplacation

Função divBN  

- Função de divisão entre BigNumber's recorrendo a funções auxiliares para calcular o quociente e o resto.

Função divBN' 

- Calculo do quociente utilizando a estratégia m * q <= l , qi = 1

Função resto 

- Cálculo do Resto da divisão

Função mulBN' 

- aplicação do algoritmo long Multiplacation com carrying

função mulBnGreater 

- função auxiliar de Multiplacação para condição de length de Y e de X, efetua a operação de soma intermédia na multiplição no algoritmo de long Multiplacation

função absBigNumber 

- valor absoluto de BigNumber

função greaterBn 

- retorna valor lógico sobre a superioridade do primeiro BigNumber sobre o segundo BigNumber

função somaBN 

- Verificação de corner cases para efetuar a soma entre dois BigNumber's

função somaBnNeg 

- efetuar a soma de um BigNumber positivo e um BigNumber negativo

função somaBN' 

- efetuar a soma com carrying entre dois números negativos e dois números positivos


## Estratégias de Implementação do Módulo BigNumber

As funções scanner e output são funções simples em que se utiliza funções padrão para chegarao objetivo.

A estratégia utilizada para as quatro funções : somaBN, mulBN, divBN, subBN foi implementar algoritmos básicos de soma, multiplição,subtração e divisão.

A função mais importante a implementar é a somaBN porque as outras três funções dependem de operações de soma.

O princípio foi definir funções auxiliares que implementavam os algoritmos de cada operação e cada função auxiliar retornar o valor da solução para a função principal.

O reconhecimento de corner cases é uma preocupação do módulo por isso cada função é responsável por reconhecer estes corner cases de cada operação e chamar de seguida a função auxiliar respetiva com argumentos corretos para as caracteristicas dos operandos.

É utilizado certas funções modificadoras de output como filterZeros, replaceNeg e reverse que modelam o resultado da função de acordo com o resultado pretendido.

Foi utilizada estratégias como soma com carrying, subtração com recurso ás propriedades da função somaBN e troca de sinais, long Multiplacation, e o uso da inequação m*q <= l para a divisão, em que q é o quociente pretendido e m e l o divisor e o dividendo.

O output nulo, ou seja 0, é reconhecido como lista vazia ([]) pelo o programa, logo qualquer resultado que inclua apenas 0 é apresentado como [].

Problemas encontrados com esta estratégia: Dificuldade em testar o código, código muito verboso pela necessidade de tratar de muitos corner cases.

## Resultado 4

#### Argumento Máximo (Estimativa) - Critério Temporal (>1 s)

fibRec: 26 
fibRecBN: 22

fibLista: 14000
fibListaBN:2500

fibListaInfinita: 70000
fibListaInfinitaBN: 2500

Conclusão: Versão Fibonacci com BigNumber aceita como arumento máximo um número muito menor para um tempo de execução de menos de 1 s pelo facto de ser efetuado muitas operações de soma auxiliares entre BigNumber's.




