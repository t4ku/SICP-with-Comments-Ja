; 1.1.8 ブラックボックス抽象としての手続き

; sqrtという手続きは、下記のように部分問題に分割できた

; sqrt -> sqrt-iter -> good-enough
;                                  -> square
;                                  -> abs
;                   -> improve     -> averate

; この場合、ある10行のプログラムを分割したというようなものではなく、good-enoughという手続きの内容に関心をおかず
; good-enoughが純分有効な値を計算して判断してくれるという、手続きの抽象(procedural abstraction)として機能している

; 従って、手続きの抽象から見ると下記の三つは同じである

(define (square x)(* x x))

(define (square x)
	(exp (double (log x))))
	
(define (square x)(+ x x))

; 局所性

; 仮パラメタはどんな名前であってもよいが、手続きの中で束縛(bind)されていないとマズい
; 手続きの中ではyは拘束変数とよばれ、手続き定義は仮パラメタを拘束する。名前が拘束されている範囲をスコープ(有効範囲)と呼ぶ

; 内部定義とブロック構造

(define (sqrt x)
	(sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
	(if (good-enough? guess x)
		guess
		(sqrt-iter (improve guess x) x)))
		
(define (square x)(* x x))
(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001 ))
	
(define (improve guess x)
	(average guess (/ x guess)))

(define (average x y)(/ (+ x y) 2))

; 単純に平方根を求める手続きの連続は上記のようになるが、sqrtが依存する他の手続の名前がグローバルで
; 固有である必要がある。

; defineはネストしても使用できる。その場合その手続きのスコープに他の手続きの名前が限定されることになる

(define (sqrt x)
	(define (squre x)(* x x))
	(define (good-enough? guess x)
		(< (abs (- (square guess) x))0.001))
	(define (average x y)(/ (+ x y) 2))
	(define (improve guess x)
		(average guess (/ x guess)))
	(define (sqrt-iter guess x)
		(if (good-enough? guess x)
			guess
			(sqrt-iter (improve guess x)x)))
	(sqrt-iter 1.0 x))

; xはsqrtの束縛関数であるからsqrtの有効範囲で使用できる。これを利用すると配下の手続きでは
; xを仮パラメタとして、明示的に受け取らなくてもxを自由変数にすることができる。
; こうしたやり方を静的有効範囲(lexical scoping)という

(define (sqrt x)
	(define (squre )(* x x))
	(define (good-enough? guess)
		(< (abs (- (square guess) x))0.001))
	(define (average a b)(/ (+ a b) 2))
	(define (improve guess)
		(average guess (/ x guess)))
	(define (sqrt-iter guess)
		(if (good-enough? guess)
			guess
			(sqrt-iter (improve guess))))
	(sqrt-iter 1.0))

(print (sqrt 5))
