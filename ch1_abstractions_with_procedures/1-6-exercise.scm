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
