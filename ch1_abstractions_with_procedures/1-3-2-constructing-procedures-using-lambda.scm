;1.3.2 Constructing procedures using lambda

;セクション1.3.1でsumを使用する際に、高階関数への引数として簡単な手続きを渡すためだけにpi-termやpi-nextなどの
;簡単な手続きを定義するのはとても不便に思える。pi-termやpi-nextなどを定義するよりも、
;'引数に対して4をインクリメントする手続き'や'引数x(引数+2)を母数とする逆数を返す手続き'と
;直接記述できる方法のほうがより便利だろう。
;これは、手続きを生成する特殊フォームであるlambdaを使えば良い。

(lambda (x) (+ x 4))
(lambda (x (/ 1.0 (* x (+ x 2)))))

;これを使えばpi-sumは下記のように書き直せる

(define (pi-sum a b)
  (sum (lambda(x) (/ 1.0 (* x (+ x 2))))
    a
    (lambda (x)(+ x 4))
    b))

;また、add-dxという余計な手続きを書かなくても
;integralの手続きも下記のように書き直せる。

;from 1.3.1
(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b))))

(define (integral f a b dx)
  (* (sum f
        (+ a (/ dx 2.0))
        (lambda (x)(+ x dx))
        b)
    dx))

;一般にlambdaは名前がないdefineといってよい
;下記２つは同じ。

(define (plus4 x)(+ 4 x))
(define plus4 (lambda (x)(+ 4 x)))

;その他の手続きを値として返す式と同様に、lambdaという式は下記のような組み合わせの中でオペレーターとして使用出来る。
;より一般的に言えば、手続きの名前を使用するコンテキストで使用出来る。

((lambda (x y z)(+ x y (square z))) 1 2 3)


;letを使用してローカル変数を作成する



