(define (square x)(* x x))
(define (sum-of-squares x y)
	(+ (square x) (square y)))
(define (f a)
	(sum-of-squares (+ a 1) (* a 2)))

;合成手続きはどのように解釈系で評価されるか？
;組み合わせの評価とほとんど同じで、組み合わせの要素を評価し、手続きを引数に作用させる

;合成手続きを引数に作用させるには、
;(1)仮パラメタを対応する引数で取り替え
;(2)手続きの本体を評価する

;与えられた引数+1と引数*2の値について、それらの二乗同士の和を求める上記の処理をfとして
;(f 5)がどのように評価されるかを見てみる

(f 5)

;まずfの本体を取り出す
;(sum-of-squares (+ a 1)(* a 2))

;次に、仮パラメタ(a)の箇所を、対応する引数で取り替える
;(sum-of-squares (+ 5 1)(* 5 2))

;これで、二つの被演算子(+ 5 1),(* 5 2)と、演算子sum-of-squaresを持つ組み合わせの評価を
;行えば良いことに成る

;二つの被演算子を評価し、sum-of-squaresの本体と仮パラメタで置き換えたら
;(+ (square 6)(square 10))

;作用的順序(applicative Order)と正規順序(normal order)


;作用的順序(applicative Order) => 置き換えモデル

;最初に演算子と被演算子を評価して、結果として表れる手続きを結果として表れる引数に適応する。
;Lispではパフォーマンス(Normal Orderでは結果が同じになる演算も複数回行われる)と、
;置き換えモデルで対処できない手続きを評価するのが複雑になることから、作用的順序(applicative Order)
;を使用している。

;(f 5)
; => fの本体を取り出す
;(sum-of-squares (+ a 1) (* a 2))
; => 形式パラメーター(formal parameter)のaを、引数の5と置き換える 
;(sum-of-squares (+ 5 1)(* 5 2))
; => オペレータの展開(square)、引数の評価、形式パラメーターとの置き換え
;(+ (square 6)(square 10))
;(+ (* 6 6)(* 10 10))
;(+ 36 100)
;136

;正規順序(normal order) => 被演算子については値が必要になるまで評価しない

;基本式のみになるまで、被演算子を完全に展開し、その後被演算子を評価(reduce)する

;(f 5)
;(sum-of-squares (+ a 1) (* a 2))
;(sum-of-squares (+ 5 1)(* 5 2))
;(+ (square (+ 5 1))(square (* 5 2)))
;(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))
;(+ (* 6 6)(* 10 10))
;(+ 36 100)
;136
