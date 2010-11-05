;Ben Bitdiddleは自分が使っているインタプリタが
;作用的順序(Applicable order)か正規順序(Normal Order)の評価を使っている
;かを確認する手順を考案した


;作用的順序(applicative Order)と正規順序(normal order)は下記の違いがる

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

;置き換えによって、基本式のみになるまで演算子を完全に展開し、その後被演算子を評価(reduce)する

;(f 5)
;(sum-of-squares (+ a 1) (* a 2))
;(sum-of-squares (+ 5 1)(* 5 2))
;(+ (square (+ 5 1))(square (* 5 2)))
;(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))
;(+ (* 6 6)(* 10 10))
;(+ 36 100)
;136


;まず、下記のような手続きを定義する

(define (p) (p))

(define (test x y)
	(if (= x 0)
		0
		y))
		
;そして、下記の式を評価する

(test 0 (p))

;この場合、それぞれのインタープリタはどのように振る舞うであろうか？
;作用的順序でも、正規順序でも特殊フォームのifは同じように評価されることを前提とする
;つまり、まず条件式が評価され、その結果により真の場合の式を評価するか偽の場合の式が評価されるかが決定される。

;作用的順序(Applicable Order)

;(test 0 (p))

;=>まず演算子と被演算子を評価する
;pが無限に評価されるため、無限ループに陥る

;正規順序(Normal Order)

;=>置き換えによって、基本式のみになるまで演算子を完全に展開する

;(test 0 (p))

;(if (= 0 0)
;	0
;	(p))

;=>その後reduceするが、pは評価しない
;0
