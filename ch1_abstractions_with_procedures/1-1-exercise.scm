;exercise 1.1
; 下記の式の結果を予測する

10
(print 10)

(+ 5 3 4)
(print (+ 5 3 4))

(- 9 1)
(print (- 9 1))

(/ 6 2)
(print (/ 6 2))

(+ (* 2 4) (- 4 6))
(print (+ (* 2 4) (- 4 6)))

(define a 3)
(print (define a 3))
;a

(define b (+ a 1))
(print (define b (+ a 1)))
;b

(+ a b (* a b))
(print (+ a b (* a b)))
;(+ 3 (+ 3 1) (* 3 (+ 3 1)))
;(+ 3 4 12)
;19

(= a b)
(print (= a b))
;#f

(if (and (> b a) (< b (* a b)))
    b
    a)

(print (if (and (> b a) (< b (* a b)))
    b
    a))

;(if (and (> (+ a 1) a) (< (+ a 1) (* a (+ a 1))))
;	(+ a 1)
;	a)
;(if (and (> (+ 3 1) 3) (< (+ 3 1) (* 3 (+ 3 1))))
;	(+ 3 1)
;	3)
;(if (and (> 4 3) (< 4 (* 3 4)))
;	4
;	3)
;(if (and (> 4 3) (< 4 12))
;	4
;	3)
;4	


(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

(print 	(cond ((= a 4) 6)
	      ((= b 4) (+ 6 7 a))
	      (else 25)))
	
;(cond ((= 3 4 ) 6)
;	  ((= 4 4) (+ 6 7 3))
;	  (else 25)
;16

(+ 2 (if (> b a) b a))

(print (+ 2 (if (> b a) b a)))

;(+ 2 (if (> (+ a 1) a) (+ a 1) a))
;(+ 2 (+ a 1))
;6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

(print (* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1)))


;(* b (+ a 1))
;(* (+ a 1) (+ a 1))
;16