; exercise 1.3
; 三つの数を引数としてとり、大きい二つの数の二乗の和を返す手続きを定義せよ

(define (biggertwo x y z)
		(if (< x y)
			(+ (* y y)
				(if (< x z)
					(* z z)
					(* x x)))
			(+ (* x x) 
				(if (< y z)
					(* z z)
					(* y y)))))
(print (biggertwo 3 4 5))
; 16 + 25 = 41