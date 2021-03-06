
;基本的な演算や手続きを定義する方法を覚えたが、言ってみれば
;チェスで駒がどう動けるかを知っただけで、典型的な開始法や戦術や
;戦略については全く知らない状態だ。手続きの結果を予想できる経験を持ち合わせていない。
;
;検討している動作の結果を視覚化する能力は熟練のプログラマーになるためには欠かせない。
;
;手続きとは計算処理の局所的な進化のパターンである。どのようにある段階の処理がその前の
;段階の上に積み重ねられるかを指定することである。手続きによって局所的に進化した処理の
;全体的な振る舞いを記述したいとする。これは一般的にとても難しいだが、処理が進化する時の
;典型的なパターンを記述してみたい。
;
;このセクションでは、簡単な手続きによって生成される処理に共通する"形状"をいくつか見てみる。
;

; 1.2.1 線形再帰と繰り返し

; まず、下記の式で定義される階乗を取り上げる
; n! = n (n-1) (n-2) 3*2*1
;
; 階乗を計算するには多くの方法があるが、一つは
; いかなる自然数nでもnの階乗はn*(n-1)!であるという実実を
; 利用する方法だ。
;
;
(define (factorial n)
  (if (= n 1)
    1
    (* n(factorial(- n 1)))))
(print (factorial 3))

;1-1-5の置き換えモデルを使用して6!を計算する過程を見る事ができる。
;
;(factorial 6)
;(* 6 (factorial 5))
;(* 6 (* 5 (factorial 4)))
;(* 6 (* 5 (* 4 (factorial 3))))
;(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
;(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
;(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
;(* 6 (* 5 (* 4 (* 3 2))))
;(* 6 (* 5 (* 4 6)))
;(* 6 (* 5 24))
;(* 6 120)
;720


;次に、違う観点から階乗を見てみる。
;n!は1*2の結果を3と、さらにその結果を4と次々に掛けていった最終結果と
;考える事ができる。

;もう少し形式的にいえば、1からnまで数え上げるカウンターと結果を維持している場合に
;階乗の計算は下記の法則に従って結果とカウンターが1からnまで変化していった結果といえる。

;結果 <- カウンター * 結果
;カウンター <- カウンター + 1

;この過程は下記の手続きで定義できる

(define (factorial n)
  (fact-iter 1 1 n))
(define (fact-iter product count max-count)
  (if(> count max-count)
    product
    (fact-iter 
      (* product count) 
      (+ 1 count) 
      max-count)))
(print (factorial 6))

;この演算の過程は置き換えモデルを使用して下記のように
;表現できる

;(factorial 6)
;(factorial   1 1 6)
;(factorial   1 2 6)
;(factorial   2 3 6)
;(factorial   6 4 6)
;(factorial  24 5 6)
;(factorial 120 6 6)
;(factorial 720 7 6)

;二つの処理の過程を比べてみると、ある観点からみるとほとんど違いがないように見える。
;どちらも同じ問題にたいして同じ算術演算をしているし、n!を計算するために必要なステップは
;同じ割合で増えている。

;最初の処理では、置き換えモデルで見てみると式を展開しその後に集約している。
;式の展開と同時に遅延処理のつながりを形成し、集約とともに演算が行われる。
;こうした、遅延処理に特徴づけられるタイプの処理を再帰的処理という。
;このような処理を行うためには実装系は後で実行される処理を気負うしておく必要がある。
;n!の演算では、遅延処理のつながり、そしてそれを記憶しておく量はnに比して線形に拡大する。

;対象的に二番目の処理は拡大したり収縮したりしない。どのステップでも、nが五のような自然数
;であっても、記憶しておかなければならない値は,現在のproduct,count,max-countの値だけである。
;このような処理を反復的処理と呼ぶ。一般的に反復的処理では処理の状態は一定の数の状態変数
;とそれを次のステップの状態変数にどのように反映するかという固定のルール、および終了条件
;によって要約される。

;この二つの処理の比較は別の視点からも捉えられる。反復的処理の場合、プログラムの変数によって
;処理の状態が完全に記述できる。途中で処理をとめたとしても、処理を再開するためには三つの
;変数を実装系に与えればよいだけだ。再帰的処理ではそうはいかない。
;この場合、実装系によって保持されプログラムの変数には現れない"処理がどの段階であるか"を
;指し示す隠れた情報があり、遅延処理時に使用される。

;反復と再帰を比較する場合に再帰的処理と再帰的手続きを混同してはいけない。
;手続きが再帰的であるという場合には、手続きの定義の中でそれ自身を参照するというは対称性
;をいうが、処理が再帰的であるとは処理がどのように展開するかを問題にしている。

;処理と手続きの違いを混同しやす一つの原因は、(AdaやPascalやCなどの)たいていの汎用言語の実装
;では記述された処理自体が反復的処理であっても、再帰的手続きを評価する際に手続きの呼び出し
;に比して必要な記憶容量が増加するからである。結果としてこうした言語では、do/repeat/until/for/while
;などの目的に特化した構成要素を使用することでしか反復的処理を記述できない。
;5章で検討するように、Schemeの実装にはこの欠点は存在しない。そこでは反復的処理は再帰的手続き
;で記述されても一定の記憶容量しか使用しない。こうした実装の特性を末尾再帰(tail-recursive)と呼ぶ。

;Exercise 1.9

;下記の手続きは二つとも正の整数を足し合わすものであり、1づつ整数を足すinc、1づつ減らすdec、
;を利用している

(define (+ a b)
  (if (= a 0)
    b
    (inc (+ (dec a)b))))

(define (+ a b)
  (if (= a 0)
    b
    (+ (dec a)(inc b))))

;代替モデルを利用し、(+  4 5)処理の過程を記述せよ。また、それぞれが反復的手続きか
;再帰的手続きか述べよ

;;;;; 最初の手続き

;(+ 4 5)
;
;(if (= 4 0)
;  5
;  (inc (+ (dec 4) 5)))
;
;(inc (+ 3 5))

;(if (= 3 0)
;  5
;  (inc (+ (dec 3) 5)))
;

;(inc (inc (+ 2 5)))

;(if (= 2 0)
;  5
;  (inc (+ (dec 2) 5)))

;(inc (inc (inc (+ 1 5))))

;(if (= 1 0)
;  5
;  (inc (+ (dec 1) 5)))

;(inc (inc (inc (inc(+ 0 5)))))

;(inc (inc (inc (inc 5))))

;(inc (inc (inc 6)))

;(inc (inc 7))

;(inc 8)

;9

;;;;; 二番目の手続き

;(+ 4 5)

;(if (= 4 0)
;  5
;  (+ (dec 4)(inc 5)))

;(+ 3 6)

;(if (= 3 0)
;  6
;  (+ (dec 3)(inc 6)))

;(+ 2 7)

;(if (= 2 0)
;  7
;  (+ (dec 2)(inc 7)))

;(+ 1 8)

;(if (= 1 0)
;  8
;  (+ (dec 1)(inc 8)))

;(+ 0 9)

;(if (= 0 0)
;  9
;  (+ (dec 0)(inc 9)))

;9

;下記のような特徴から一番目の手続きは
;再帰的、二番目の手続きは反復的といえる

;一番目
;手続きの呼び出しが拡張/収縮する
;
;二番目
;手続きの呼び出しパラメータが現時点の値を保持しており状態変数に依存している。



;Exercise 1.10 
;下記はAckermann関数と呼ばれる数学の関数を計算する手続き

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0)(* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
              (A x (- y 1))))))

;下記の結果を考えよ

(A 1 10)

(A 2 4)

(A 3 3)

;次に下記の手続きを検討せよ、Aは上記で定義されている手続きとする。

(define (f n)(A 0 n))
(define (g n)(A 1 n))
(define (h n)(A 2 n))
(define (k n)(* 5 n n))

;f,g,hについて、簡潔な数学的な定義を述べよ。例として(k,n)は5n^2を計算する

;回答
;(A 1 10)の評価

;xが0になるか、yが0もしくは1になるまでは
;条件文のelseにしか適応されず、それまで再帰的に
;処理が拡張していく
;
;(A 1  10)
;(A 0 (A 1 9))
;(A 0 (A 0 (A 1 8)))
;(A 0 (A 0 (A 0 (A 1 7))))
;(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 32))))))
;(A 0 (A 0 (A 0 (A 0 64)))))
;(A 0 (A 0 (A 0 128))))
;(A 0 (A 0 256)))
;(A 0 512))
;1024

;(A 2 4)の評価

;(A 2 4)
;(A 1 (A 2 3))
;(A 1 (A 1 (A 2 2)))
;(A 1 (A 1 (A 1 (A 2 1))))
;(A 1 (A 1 (A 1 2)))
;(A 1 (A 1 (A 0 (A 1 1))))
;(A 1 (A 1 (A 0 2)))
;(A 1 (A 1 4))
;(A 1 (A 0 (A 1 3))
;(A 1 (A 0 (A 0 (A 1 2))))
;(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
;(A 1 (A 0 (A 0 (A 0 2))))
;(A 1 (A 0 (A 0 4)))
;(A 1 (A 0 8))
;(A 1 16)
;(A 0 (A 1 15))
;(A 0 (A 0 (A 1 14))) 
;(A 0 (A 0 (A 0 (A 1 13))))
;(A 0 (A 0 (A 0 (A 0 (A 1 12)))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10)))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6)))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512)))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
;(A 0 (A 0 (A 0 (A 0 4096))))
;(A 0 (A 0 (A 0 8192)))
;(A 0 (A 0 16384))
;(A 0 32768)
;65536

;(A 3 3)の評価

;(A 3 3)
;(A 2 (A 3 2))
;(A 2 (A 2 (A 3 1)))
;(A 2 (A 2 2))
;(A 2 (A 1 (A 2 1))
;(A 2 (A 1 2))
;(A 2 (A 0 (A 1 1)))
;(A 2 (A 0 2))
;(A 2 4)
;(A 1 (A 2 3))
;(A 1 (A 1 (A 2 2)))
;(A 1 (A 1 (A 1 (A 2 1))))
;(A 1 (A 1 (A 1 (A 1 (A 2 0)))))
;(A 1 (A 1 (A 1 (A 1 0))))
;(A 1 (A 1 (A 1 2)))
;(A 1 (A 1 (A 0 (A 1 1))))
;(A 1 (A 1 (A 0 2)))
;(A 1 (A 1 4))
;(A 1 (A 0 (A 1 3)))
;これ以後は(A 2 4)と同じ
;65536


;f,g,kについての数学的な定義

;(define (A x y)
;  (cond ((= y 0) 0)
;        ((= x 0)(* 2 y))
;        ((= y 1) 2)
;        (else (A (- x 1)
;              (A x (- y 1))))))

;;;; (define (f n )(A 0 n))の数学的な定義
;
;Aの定義から,x=0の時の手続きである
;(define (f n )(* 2 n))
;したがって、(f,n) = 2n


;;;; (define (g n)(A 1 n))の数学的な定義

;(A 1 10)の計算過程をみると
;
;x=1,y=1(このとき(A 1 1) => 2)になるまで、下記のように拡大し
;
;(A 1  10)
;(A 0 (A 1 9))
;(A 0 (A 0 (A 1 8)))
;(A 0 (A 0 (A 0 (A 1 7))))
;(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))

;拡大した分だけ2の掛け合わすことで、収縮する

;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 32))))))

;したがって、(g,n) = 2^nといえる

;;;; (define (h n)(A 2 n))の数学的な定義

;(A 2 4)の計算過程において、(A 1 16)となるまで
;の処理を見てみる。(※(A 1 16)は(g,n)=2^nから2^16と計算できる)

;(A 2 4)
;(A 1 (A 2 3))
;(A 1 (A 1 (A 2 2)))
;(A 1 (A 1 (A 1 (A 2 1))))
;(A 1 (A 1 (A 1 2)))
;(A 1 (A 1 (A 0 (A 1 1))))
;(A 1 (A 1 (A 0 2)))
;(A 1 (A 1 4))
;(A 1 (A 0 (A 1 3))
;(A 1 (A 0 (A 0 (A 1 2))))
;(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
;(A 1 (A 0 (A 0 (A 0 2))))
;(A 1 (A 0 (A 0 4)))
;(A 1 (A 0 8))
;(A 1 16)
;
;(A 1 (A 1 4))の段階で
;2^nのnの部分が(A 1 4) = 2^4で表されている
;つまり、(A 1 4)が2^4であるのに対して、(A 2 4)は2^16 = 16^4となり
;(A 2 n)は16^nと表せる

;従って、(h n)=16^n
