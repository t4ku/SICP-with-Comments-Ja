;1.2.2 木構造再帰

;典型的な演算のパターンには他にも、木構造再帰と呼ばれるものがある。
;例えば、数字が前の二つの合計となるように連なる数列であるフィボナッチ数を
;例に考えてみる。

;0,1,1,2,3,5,8,13,21...

;一般的にフィボナッチ数は下記のルールで定められる

;Fib(n) = 0                   if n = 0
;         1                   if n = 1
;         Fib(n-1) + Fib(n-2) otherwise

;このルールに従って、フィボナッチ数を求める
;手続きは簡単にかける

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else(+ (fib (- n 1))
                 (fib (- n 2))))))

;(fib 5)の処理の流れは下記のようになる。

;(fib 5)
;(+ (fib 4)(fib 3))
;(+ (+ (fib 3)(fib 2))(+ (fib 2)(fib 1)))
;(+ (+ (+ (fib 2)(fib 1))(+ (fib 1)(fib 0))(+ (+ (fib 1)(fib 0))(+ (fib 1)(fib 0)))))
;(+ (+ (+ (+ (fib 1)(fib 0))(fib 1))(+ (fib 1)(fib 0))(+ (+ (fib 1)(fib 0))(+ (fib 1)(fib 0)))))

;これは下記の木構造で表せる

;                                        fib 1
;                            fib 2 = +
;                                        fib 0
;                fib 3 = +
;                            fib 1
;    fib 4 = +
;                            fib 1
;                fib 2 = +
;                            fib 0
;+
;                            fib 1
;                fib 2 = +  
;                            fib 0
;    fib 3 = +
;                fib 1

;この演算のパターンを考えると、(fib 5)を求めるために(fib 4)と(fib 3)が必要だ。
;(fib 4)を求めるためには(fib 3)(fib 2)が必要だ。一般的に、これは上記の木構造
;のように進化する。末端以外のすべての節は2つに分岐する。これはfibという手通続き
;が呼び出されるたびに二回自分自身を呼び出すことを示している。

;この手続きは典型的な木構造の再帰として分かりやすいが、演算が冗長であるため
;フィボナッチ数の計算方法としてはひどいやり方だ。例えば(fib 3)は二回行われている。
;実際(fib 1)や(fib 0)の呼び出し回数がFib(n+1)※末端の数　であることは簡単に分かる。

;これがどれくらいひどいかを示すために、Fib(n)が指数関数的に増大すると言ってもいい。
;もっと性格にいうとFib(n)はΦが下記の条件を満たす時の、Φ^n/√5に近似する整数である。
;Φ = (1 + √5) / 2 ≈ 1.6180、つまり黄金比であり、 Φ^2 = Φ + 1を満たす。

;したがって、処理は入力に応じて指数関数的に増加するステップ数が必要となる。
;一方で、演算のいかなる段階においても上位の節がどれであるかさえ捕捉しておけばよいので、
;記憶すべき内容は入力に線形にしか増加しない。一般的に、木構造の再帰手続きでは演算に
;必要なステップ数は木の節の数に比例し、記憶すべき内容は木構造の深さの最大値に比例する。

;フィボナッチ数の演算について、反復的手続きを公式化する事もできる。
;考え方は、aとbという対になる整数を使用し、Fib(1) = 1、Fib(0) = 0で初期化し、
;下記の変形を同時に適応していく

;a <- a + b
;b <- a

;n回適応したあとaとbはそれぞれFib(n+1),Fib(n)となることは想像に難くない。
;したがって、下記の手続きを使用すればフィボナッチ数を反復的に演算できる。

(define (fib n)
  (fib-iter 1 0 n))
(define (fib-iter a b n)
  (if (= n 0)
       b 
       (fib-iter (+ a b) a (- n 1))))

;この二番目の手続きは線形反復という。
;最初に定義したfibと、上記のfibにおける必要となるステップ数の違いは小さな値が入力で
;あったとしても非常に大きなものとなる。

;これをもって、木構造の再帰手続きは無用と断定すべきではない。
;数値でなく階層構造のデータを処理することを検討するとき、木構造の再帰手続き
;は自然で強力なツールとなる。また、数値に対して処理を行う場合でも、
;プログラムを理解し設計する際に木構造の再帰手続きは役にたつ。
;例えば、最初のfibという手続きは2番目の手続きに比べ、演算効率からいうと大いに非効率
;だが、ほとんどフィボナッチ数列をLispの手続き置き換えただけのものなので、直感的に理解しやすい。
;反復アルゴリズムを思いつくには、3つの状態変数を使用して演算を繰り返すことができるということ
;に気づく必要がある。

; 例. 両替を数える

;反復的なフィボナッチアルゴリズムを考えだすには少し賢さが必要だ。対照的に
;下記の問題を考えてみる。
;1ドルを、50セント/25セント10セント/5セント/1セントを使用して両替する
;組み合わせは何通りあるだろうか？もう少し一般的に言って、あるお金の量を
;両替する組み合わせの数を計算する手続きをかけるだろうか？

;この問題には再帰的手続きとしてのある簡単な解決方法がある。
;利用可能なコインの種類がある並び順で整列されていると仮定すると、
;下記の関係が成り立つ。
;n種類のコインを使用してaの金額を両替するための組み合わせは、
; - 最初の種類のコイン以外のすべての種類のコインを使用してaの金額を両替する組み合わせ
; - dを最初のコインの金額としたときに、n種類のコインすべてを使用して、a - d の金額を両替する組み合わせ
;
;の合計である。
;
;これが正しいかどうかを理解するには、両替を行う方法を2つのグループに分けてみればよい
;最初の種類のコインを使用しない方法と、使用する方法である。
;したがって、ある金額の両替を行うやり方は、最初の種類のコインを使用しないやり方と、
;最初のコインを使用することを仮定し、両替を行うやり方の合計である。ただし、後者の
;組み合わせの数は、最初の種類のコインを一つ使った残りの金額についての両替の組み合わせの
;数に等しい。

;したがって、与えられた金額の両替を行う問題をより少ない種類でより少ない金額
;の両替の問題へと再帰的に減少させていく事ができる。
;この減少のルールを注意深く検討し、アルゴリズムを記述するために利用できると
;理解するために、減少のケースを下記のように特定する。

;a => 金額
;n => コインの種類

; - aがちょうど0であった場合、両替を行う1つの組み合わせとしてカウントする
; - aが0よりも小さかった場合、両替を行う組み合わせを0としてカウントする
; - nが0であった場合、両替を行う組み合わせを0としてカウントする

;50/25/10/5/1セントという風にコインの種類を並べるとして、
;上記のルールがあてはまる過程を確かめてみる。


;(cc 100 5)

;(+ (cc 100 4)(cc 50 5))

;(+ 
;  (+ (cc 100 3)(cc 75 4))
;  (+ (cc 50 4)(cc 0 5)))

;(+ 
;  (+ 
;    (+ (cc 100 2)(cc 90 3))
;    (+ (cc 75 3)(cc 50 4))
;  (+ 
;    (+ (cc 50 3)(cc 25 3))
;    (+ (cc 0 5)))))

;(+ 
;  (+ 
;    (+ 
;      (+ (cc 100 1)(cc 95 2))
;      (+ (cc 90  2)(cc 80 3))
;    (+ 
;      (+ (cc 75 2)(cc 65 2))
;      (+ (cc 50 3)(cc 45 4))
;  (+ 
;    (+ 
;      (+ (cc 50 2)(cc 40 3))
;      (+ (cc 25 2)(cc 15 3))
;    (+ 
;      (cc 0 5)))))
;

;(+ 
;  (+ 
;    (+ 
;      (+ 
;        (+(cc 100 0)(cc 99 1))
;        (+(cc 95 1)(cc 90 2)))
;      (+ 
;        (+(cc 90 1)(cc 85 2))
;        (+(cc 80 2)(cc 70 3))))
;    (+ 
;      (+ 
;        (+(cc 75 1)(cc 70 2))
;        (+(cc 65 1)(cc 60 2)))
;      (+ 
;        (+(cc 50 2)(cc 40 3))
;        (+(cc 45 3)(cc 20 4))))
;  (+ 
;    (+ 
;      (+ 
;        (+(cc 50 1)(cc 45 2))
;        (+(cc 40 2)(cc 30 3)))
;      (+ 
;        (+(cc 25 1)(cc 20 2))
;        (+(cc 15 2)(cc 5 3))))
;    (+ 
;      (cc 0 5)))))
;

;(+ 
;  (+ 
;    (+ 
;      (+ 
;        (+
;          (cc 100 0)
;          (+ (cc 99 0)(cc 98 1)))
;        (+
;          (+(cc 95 0)(cc 94 1))
;          (+(cc 90 1)(cc 85 2))))
;      (+ 
;        (+
;          (+ (cc 90 0)(cc 89 1))
;          (+ (cc 85 1)(cc 80 2)))
;        (+
;          (+ (cc 80 1)(cc 75 2))
;          (+ (cc 70 2)(cc 60 3)))))
;    (+ 
;      (+ 
;        (+
;          (+ (cc 75 0)(cc 74 1))
;          (+ (cc 70 1)(cc 65 2)))
;        (+
;          (+ (cc 65 0)(cc 64 1))
;          (+ (cc 60 1)(cc 55 2))))
;      (+ 
;        (+
;          (+ (cc 50 1)(cc 50 2))
;          (+ (cc 40 2)(cc 30 3)))
;        (+
;          (+ (cc 45 2)(cc 30 3))
;          (+ (cc 20 3)(cc -5 4)))))
;  (+ 
;    (+ 
;      (+ 
;        (+
;          (+ (cc 50 0)(cc 49 1))
;          (+ (cc 45 1)(cc 45 2)))
;        (+
;          (+ (cc 40 1)(cc 35 2))
;          (+ (cc 30 2)(cc 20 3)))
;      (+ 
;        (+
;          (+ (cc 25 0)(cc 24 1))
;          (+ (cc 20 1)(cc 15 2)))
;        (+
;          (+ (cc 15 1)(cc 10 2))
;          (+ (cc 5  2)(cc -5 3))))))
;    (+ 
;      (cc 0 5)))
;

;上記の流れで分かるように、ccという手続きがその内部で条件分岐するので、
;金額とコインの種類を渡したときの両替の組み合わせに対して、あり得ない金額と種類の
;組み合わせであっても、0を返す事で木構造が成り立っている。
;木構造再帰が金額とコインの種類の総当たりとして拡張している。
;適切な組み合わせを想像するには、（cc 0 x)となる節を探せばよい。
;上記の試行ではまだ、出現していないが、(cc 5 2)はその次の拡張で
;(+ (cc 5 1)(cc 0 2))となるので、二番目の呼び出しが1個の組み合わせとして数えられる。

(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0)1)
        ((or (< amount 0)
            (= kinds-of-coins 0))
            0)
        (else 
          (+
            (cc amount (- kinds-of-coins 1))
            (cc (-
                  amount
                  (first-denomination kinds-of-coins))
                kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond 
    ((= 1 kinds-of-coins) 1)
    ((= 2 kinds-of-coins) 5)
    ((= 3 kinds-of-coins) 10)
    ((= 4 kinds-of-coins) 25)
    ((= 5 kinds-of-coins) 50)))
(print (count-change 100))

;上記の手続きcount-changeは最初のfibの実装と同じように冗長な演算を行っている。
;一方で、これよりもよいアルゴリズムについてはまだ明らかでないので課題としておく。
;木構造再帰手続きはかなり非効率だが簡潔に定義でき、理解しやすいので、木構造再帰を
;同じ結果に帰着する、より効率的な手続きに変換する"スマートコンパイラ"を設計することで、
;両方の世界のよいところを組み合わせようという提案がこれまでなされてきた。