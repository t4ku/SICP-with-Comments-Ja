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

;この手順を形式化する

(define (square x)(* x x))

(define (improve guess x)
	(average guess (/ x guess)))

(define (average x y)
	(/ (+ x y) 2))

(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
	(sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
	(if (good-enough? guess x)
		guess
		(sqrt-iter (improve guess x)
					x)))
(print (sqrt 9))
