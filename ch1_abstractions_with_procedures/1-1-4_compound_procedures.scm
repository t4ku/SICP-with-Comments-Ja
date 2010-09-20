
;: (define (<name> <formal parameters>) <body>)
;これは合成手続きと呼ばれる。引数には局所的な名前xがつけられる
;二乗を計算する例
(define (square x)(* x x))
(print (square 4))

;定義された合成手続きはさらに別の手続きでも使用することができる
(define (sum-of-squares x y)
	(+ (square x) (square y)))
(print (sum-of-squares 3 4))

(define (f a)
	(sum-of-squares (+ a 1) (* a 2)))
(print (f 5))
