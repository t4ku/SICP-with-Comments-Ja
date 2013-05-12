;1-2-6 Example: Testing for Primality

;このセクションでは整数nが素数であるかをチェックする2つの方法を記載する。
;一つはΘ(√n)の計算量で、もうひとつはΘ(log n)の計算量を持つ蓋然的なアルゴリズムだ。
;セクションの最後にはこれらのアルゴリズムにもとづくプログラミングの課題をのせる。

;公約数をさがす

;古代から数学者は素数にまつわる問題に惹きつけられており、多数の数学者は整数が素数であるかを
;チェックする方法を求めてきた。素数を求める一つの方法は公約数を探すことだ。下記は
;与えられた整数nの最小の因数を見つける手続きである。
;この手続では素直に2から始めてnが割り切れるか順々に調べていく。

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)n) ; もしnが素数でないなら、√n以下に約数をもっているはず(終了条件)
        ((divies? n test-divisor) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divies? a b)
  (= (remainder a b) 0))
(define (square x)(* x x))

(define (prime? n)
  (= n (smallest-divisor n)))

(print (prime? 7))

;終了条件から公約数は1から√nまでの値を調べればよいことがわかるので、
;計算量はΘ(√n)となる。

;フェルマーテスト

;Θ(log n)となる素数テストはフェルマーの小定理として定理の結果から導ける。

;フェルマーの小定理
;nが素数でaがn以下の正の整数である場合、aのn乗は法をnとしてnと合同である。
;(ややこしいが、a^n ≡ a(mod n) ということ)

;nが素数でない場合、一般にa < nを満たすほとんどの数について上記は成り立たない。
;これにより下記の素数テストのアルゴリズムが導ける。

;整数nに対してa < nとなるランダムな正数を選ぶ、a^nに対してnを法とする序数を求める。
;これがaでなければ、nは確実に素数ではない。反対にaであれば素数の確率が高い。
;その場合はまた別の正数をaとして選び、同じ方法でテストする。これを繰り返すほど
;nが素数であることの確率は高いといえる。

;フェルマーテストを実装するには、ある数(base)のべき乗(exp)について別の数(m)を法とした序数を求める
;手続きが必要だ。

(define (expmod base exp m)
  (cond ((= exp 0) 1) ; baseがどのような正数でも0乗は1だし、mで割った余りも1となる
        ((even? exp) ; expが2x?乗である場合、mod(base^exp)はmod(base^(exp/2)^2)と括り出せる
         (remainder (square (expmod base (/ exp 2) m))
                    m))
         (else       ; その他の場合、mod(base^exp)はmod(base*base^(exp-1))
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

;上記の手続きはsection 1.2.4のfast-exptによく似ている。逐次平方を用いているため
;計算量はべき乗に対して対数的に増加する

;フェルマーテストは、1からn-1の値(両端を含む)をランダムに選んでa^nのnを法とした序数がaと等しいか
;をチェックすることで実施できる。ランダムな数aはSchemeのプリミティブとして含まれるramdom関数
;を使用する。randomは引数の整数以下の正数を返す。したがって、1からn-1までの正数を得たい場合は、
;ramdomにn-1を与えて、結果に1を加える。

;gaucheでrandomが使えなかったので、random-integer

(use srfi-27)

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (random-integer n)))

(print (fermat-test 4))

;これで、ランダムな1からn-1の正数に対して、nが素数であるかどうかを
;確認するテストを1下位実施できるようになった。これを一定数繰り返す手続きは下記

(define (fast-prime? n times)
  (cond ((= times 0) #f)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(print (fast-prime? 11 5))

;確率的な手法(probabilistic methods)

;fermatテストは、必ず正しいことが保証されないという点でよく知られているアルゴリズムとは
;性質が異なる。得られる結果は確率的に正しいとしか言えない。nという数字がfermatに失敗すれば
;素数でないということは言えるが、逆にnがパスし続けていても素数である保証はない(確率的には高くなるが)
;重要なのはテストの回数を多くすることで確率の精度は向上し続けるということだ。

;というものの、実はそうとも言えず、素数でないのにfermatテストにパスし続ける数もかなり稀だが存在する。
;実用上は問題なく、このケースを考慮したfermatテストもある(exercise 1.28)

; TODO:
;Exercise 1.21

;Exercise 1.22

;Exercise 1.23

;Exercise 1.24

;Exercise 1.25

;Exercise 1.26

;Exercise 1.27

;Exercise 1.28
