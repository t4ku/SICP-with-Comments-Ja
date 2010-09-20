;現時点で使用できる手続きの表現力は限定されている。なぜなら、テストを行いそのテストの結果に従って
;違う処理を行う方法がないからだ。
;
;例えば、数の絶対値を求める手続きを定義できない。これは、与えられた数が負数、0、整数によって返す値を
;変更する必要があるからだ。
;
;これらは場合分け（case analysis）といい、lispではcondと呼ばれる特殊フォームによって
;記述することができる。

(define (abs x)
	(cond ((> x 0) x)
		((= x 0) 0)
		((< x 0) (- x))))
(print (abs -5))

;(cond (<p1> <e1>)
;	  (<p2> <e2>)
;	  (<p3> <e3>)
;	  (<pn> <en>))

;cond の次にclauses(節)という式の対を記述する。
;pはpredicate(述語)と呼ばれ、値を真か偽と解釈する式である。eは帰結式(consequent expression)と
;よばれ、predicateが芯であった場合、対応する帰結式を条件式の戻り値とする。

(define (abs x)
	(cond 
		((< x 0)(- x))
		(else x)))
(print (abs -8))

;さらに明示的にelseを使用せずに、
;(if <predicate> <consequent> <alternative>)という形式を使うこともできる

(define (abs x)
	(if (< x 0)
		(- x)
		 x))
(print (abs -4))

;基本的なpredicate(値を真か偽と解釈する式である)のほかに、andとor、notなどの論理複合述語もある

;(and <e1> <e2>...<en>)
;(or <e1> <e2>...<en>)
;(not <e>)

;andとorはspecial form(特殊フォーム)である、子要素は必ずしも評価されない。
;notは通常のprocedureである

(define (>= x y)
  (or (> x y) (= x y)))

(print (>= 10 2))

(define (>= x y)
  (not (< x y)))

(print (>= 10 22))
