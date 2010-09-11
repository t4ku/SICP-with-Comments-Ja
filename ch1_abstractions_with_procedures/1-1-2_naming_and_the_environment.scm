;: 値に名前をつけるのは、defineを使用する
(define size 2)
size
(* 5 size)

;: piという名前で3.14159という値を参照できる
(define pi 3.14159)

;: radiusという名前で10という値を参照できる
(define radius 10)

;: 面積を求める
(* pi (* radius radius))
;: 演算の結果にも名前を付けられる
(define circumference (* 2 pi radius))

(print circumference)