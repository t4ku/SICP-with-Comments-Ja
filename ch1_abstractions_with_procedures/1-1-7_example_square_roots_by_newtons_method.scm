;例：Newton法による平方根

; 数学の関数とコンピューターが扱う手続きには重要な違いがある。

;数学的には下記のような関数を定義することはできるが、
;rの平方根 = y >= 0 かつy^2 = rであるようなy

;これは手続きについて、なにも言及していない。
;どのようにして平方根を求めるかについては何も言っておらず

;(define (sqrt x)
;	(the y (and (>= y 0)
;		 		(= (square y) x))))

;のようにlisp風に言い換えても意味がない

;数学的な関数と、手続きの違いには、ものごとの属性を記述すること、つまり宣言的な知識と、
;どのように処理するかを記述すること、つまり命令的な知識、との違いが反映されている。

;数学ではwhat is,コンピューター科学ではhow toに関心が分かれている。

;では平方根はどのように計算するか、通常ではNewton法をしようして、次々に近似をとる。
;http://poset.jp/orfm/node2.html

;数xの平方根の予測値をyとすると、yとx/yの平均値がよりよい予測値(y)となる
;例えば2の平方根を計算するときx = 2,予測値(=y)は最初1とする

;Guess(予測値)　　Quotient(商)　　　　　　　　　　　Average
;  
;1 	　　　　　　　　　(2/1) = 2 　　　　　　　　　　　　((2 + 1)/2) = 1.5
;1.5 　　　　　　　　(2/1.5) = 1.3333 	　　　((1.3333 + 1.5)/2) = 1.4167
;1.4167 　　　　　(2/1.4167) = 1.4118 　　((1.4167 + 1.4118)/2) = 1.4142
;1.4142 	...	...

; 7の平方根を、最初3と予測する

; x : 求めたい平方根の対称となる数字(=7)
; y1 : 最初の予測値(=3)

; y2 = y1 + x / y1 = { 3    + (7 / 3)  } / 2 = 2.3333
; y3 = y2 + x / y2 = { 2.3  + (7 / 2.3)} / 2 = 2.67
; y4 = y3 + x / y3 = { 2.67 + (7 /2.67)} / 2 = 2.64

;この手順を形式化する

(print (sqrt 11))

; 最初の予想値を1として、再帰的に評価する
(define (sqrt x)
	(sqrt-iter 1.0 x))

; 予測値が妥当であればそれを返し、精度が低い場合は精度を高めた予測値で再帰呼び出し
(define (sqrt-iter guess x)
	(if (good-enough? guess x)
		guess
		(sqrt-iter (improve guess x)
					x)))

; 予測値を2乗した値が、元の値と1000分の1単位で違わなければ妥当					
(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))

; yn+1 = ( yn + x / y ) / 2
(define (improve guess x)
	(average guess (/ x guess)))					

(define (square x)(* x x))

(define (average x y)
	(/ (+ x y) 2))

;--------------------
; exercise 1.6
;--------------------

; if が特殊フォームである必要があるのか？
; new-ifという合成手続きを使って1-5のニュートン法による平方根を求める処理を実行してみる

(define (new-if predicate then-clause else-clause)
		(cond (predicate then-clause)
		  	  (else else-clause)))

(print (new-if (= 0 0) 1 2))

(print (sqrt 389))

; new-ifではthen-clause else-clauseともに評価するので、
; sqrt-iterで無限ループになる

;----- 1-6
		
; 最初の予想値を1として、再帰的に評価する
(define (sqrt x)
	(sqrt-iter 1.0 x))

; 予測値が妥当であればそれを返し、精度が低い場合は精度を高めた予測値で再帰呼び出し
(define (sqrt-iter guess x)
	(new-if (good-enough? guess x)
		guess
		(sqrt-iter (improve guess x)
					x)))

; 予測値を2乗した値が、元の値と1000分の1単位で違わなければ妥当					
(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))

; yn+1 = ( yn + x / y ) / 2
(define (improve guess x)
	(average guess (/ x guess)))					

(define (square x)(* x x))

(define (average x y)
	(/ (+ x y) 2))
