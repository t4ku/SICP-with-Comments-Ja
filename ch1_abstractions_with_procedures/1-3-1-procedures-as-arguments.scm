;1.3 Formulating Abstractions with Higher-Order Procedures

;$B$3$l$^$G<jB3$-$r!"FCDj$N?tCM$K0MB8$7$J$$J#9g$7$?A`:n$rCj>]2=$7$?$b$N$H$7$F8+$F$-$?!#(B

(define (cube x)(* x x x))

;$B$3$N$h$&$K=q$/$H!"FCDj$NN)J}BN$K$D$$$FBN@Q$r5a$a$k$N$G$O$J$/!"(B
;$B$I$N$h$&$J%5%$%:$NN)J}BN$NBN@Q$b5a$a$k$3$H$,$G$-$k!#(B

;$B$b$A$m$s$3$&$7$?<jB3$-$rMQ$$$J$$$G!"C`0l2<5-$N$h$&$J<0$r;HMQ(B
;$B$9$k$3$H$G5a$a$k;v$b$G$-$k(B
;(* 3 3 3)
;(* x x x)
;(* y y y)

;$B$?$@$3$&$9$k$H!">o$K$?$$$F$$8@8l$N%W%j%_%F%#%V(B($B$3$N>l9g$O>h;;(B)$B$N%l%Y%k$G(B
;$BFCDj$N1i;;$r9M$($J$$$H$$$1$J$$$H$$$&>u67$r:n$j=P$7!"9b<!85$G$N<jB3$-$G(B
;$B9M$($k$3$H$,Fq$7$/$J$k!#:n$C$?%W%m%0%i%`$O3N$+$KN)J}BN$NBN@Q$r5a$a$i$l$k$,!"(B
;$B$=$3$KI=$7$?8@8l$G$O!VN)J}BN$NBN@Q$r5a$a$k!W$H$$$&35G0$rI=8=$G$-$F$$$J$$$3$H$K$J$k!#(B
;$B6/NO$J%W%m%0%i%_%s%08@8l$K5a$a$k$Y$-$3$H$O6&DL$N%Q%?!<%s$KL>A0$r3d$jEv$F$FCj>]2=$G$-$k$3$H!"(B
;$B$5$i$K$=$NCj>]%l%Y%k$G9M$($l$k$h$&$K$9$k$3$H$@!#<jB3$-$O$3$N5!G=$rDs6!$9$k!#(B
;$B$f$($K!"K\Ev$K86;OE*$J%W%m%0%i%_%s%08@8l0J30$G$O<jB3$-$rDj5A$9$k%a%+%K%:%`$,MQ0U$5$l$F$$$k!#(B

;$B$7$+$7!"<jB3$-$N%Q%i%a!<%?!<$K?t;z$7$+;HMQ$G$-$J$$$H$J$k$H!"?tCM$N7W;;$G$5$($b2f!9$NCj>]2=$r(B
;$B9T$&G=NO$O$+$J$j@)8B$5$l$k$@$m$&!#F1$8%W%m%0%i%_%s%0$N%Q%?!<%s$,0[$J$k<jB3$-$G;HMQ$5$l$k$3$H$O(B
;$B$7$P$7$P$"$k!#$3$&$7$?%Q%?!<%s$r%3%s%;%W%H$H$7$FI=8=$9$k$K$O!"<jB3<+BN$r0z?t$K$H$C$?$j(B
;$BLa$jCM$H$7$F<jB3$-$rJV$7$?$j$9$k<jB3$-$rDj5A$G$-$kI,MW$,$"$k!#(B
;$B$3$&$7$?<jB3$rA`:n$9$k<jB3$-$r(Bhiger-order procedure($B9b3,<jB3$-(B)$B$H$$$&!#(B
;$B0J2<$N%;%/%7%g%s$G$O!"9b3,<jB3$-$r$I$N$h$&$K$7$F6/NO$JCj>]2=$N%a%+%K%:%`$H$7$F;HMQ$7!"(B
;$B8@8l$NI=8=NO$rBgI}$K3HD%$G$-$k$+Ds<($9$k!#(B

;1.3.1 $B0z?t$H$7$F$N<jB3$-(B

;$B2<5-$N(B3$B$D$N<jB3$-$r9M$($F$_$k!#(B
;1$B$D$a$O(Ba$B$+$i(Bb$B$N@0?t$N9g7W$r7W;;$9$k!#(B

(define (sum-integer a b)
    (if (> a b)
        0
        (+ a (sum-integer (+ a 1) b))))
(print (sum-integer 2 5))

;2$BHVL\$O!"M?$($i$l$?HO0O$N@0?t$N(B3$B>h$N9g7W$r7W;;$9$k(B
(define (sum-integer-cube a b)
    (if (> a b)
        0
        (+ (* a (* a a)) (sum-integer-cube (+ a 1) b))))
(print (sum-integer-cube 2 5))

;3$B$D$a$O!"(B1 / (1 * 3) + 1 / (5 * 7) + 1 / (( * 9 11) $B$H$$$&(B
;$BO"B3$N?t$N9g7W$r5a$a$k(B($B$3$l$O&P(B/8$B$K<}B+$9$k(B)

(define (pi-sum a b)
    (if (> a b)
        0
        (+ (/ 1 (* a (+ a 2)))(pi-sum (+ a 4) b))))
(print (pi-sum 2 5))

;$B$3$l$i$N<jB3$-$OL@$i$+$K6&DL$N%Q%?!<%s$rM-$7$F$$$k!#(B
;$B$3$l$i$O$[$H$s$I$9$Y$F$N>l=j$GF10l$G$"$j!"0c$&$N$O<jB3$-L>(B
;$B$H7W;;BP>]$N(Ba$B$rI=8=$9$k2U=j!"$=$7$F<!$N(Ba$B$rI=8=$9$kItJ,$N$_$G$"$k!#(B
;$BF1$8%F%s%W%l!<%H$G%Q%i%a!<%?!<$rJQ$($k$@$1$G$$$:$l$N<jB3$-$b:n$l$F$7$^$&!#(B

;(define (<name> a b)
;    (if (> a b)
;        0
;        (+ (<term> a)
;           (<name> (<next> a)b))))

;$B$3$&$7$?6&DL$N%Q%?!<%s$,B8:_$9$k$H$$$&$3$H$O!"M-MQ$JCj>]2=$,<BAu$G$-$k$3$H(B
;$B$r<($7$F$$$k!#(B
;$B<B:]!"0lO"$N?t;z$N9g7W$rCj>]2=$G$-$k$3$H$r?t3X<T$O?oJ,@N$KH/8+$7!"(B
;$B%7%0%^5-9f$rH/L@$7$?!#(B

;b$B&2(Bn=a f(n) = f(a) + ... + f(b)

;$B%7%0%^I=5-$N$J$K$,6/NO$+$H8@$($P!"$3$l$K$h$C$F?t3X<T$?$A$O(B
;$BFCDj$N9g7WCM$@$1$G$O$J$/!"AmOB<+BN$N35G0$r07$($k$h$&$K$J$C$?!#(B
;$BNc$($P!"AmOB$NBP>]$H$J$kFCDj$N?t$NO"$J$j$K0MB8$7$J$$!"0lHLE*$J(B
;$BAmOB$N7W;;7k2L$r8x<02=$G$-$k$h$&$K$J$C$?!#(B

;$BF1MM$K%W%m%0%i%`$N@_7W<T$H$7$F!"FCDj$NAmOB$r5a$a$k<jB3$-$r=q$/$N$G$O$J$/(B
;$BAmOB$H$$$&35G0<+?H$N<jB3$-$r$+$1$k$h$&$K!"6/NO$J8@8l$r:n$j$?$$$H;W$&$@$m$&!#(B
;$B$9$G$K2f!9$N<jB3$-E*$J8@8l$G$b!">e5-$N6&DL%F%s%W%l!<%HFb$N%9%m%C%H$r(B
;$B8x<0$J%Q%i%a!<%?!<$KJQ49$9$k$3$H$G<B8=$G$-$k!#(B

(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b))))

;term$B$O?tNs$N0l$D$NMWAG$NCM$r5a$a$k<jB3$-!"(B
;next$B$O?tNs$N<!$NMWAG$r5a$a$k<jB3$-!"$H$J$k!#(B
;$BNc$($P!"M?$($i$l$?HO0O$N?tCM$NN)J}BN$r9g7W$9$k(B2$BHVL\$N<jB3$-$rE,MQ$9$k$H(B

(define (inc a)(+ a 1))  ; next
(define (sum-cubes a b)  ; term$B$O(Bcube($BAH9~$_4X?t(B)
    (sum cube a inc b))
(print (sum-cubes 2 5))

;$BM?$($i$l$?HO0O$N?tCM$rC1=c$K9g7W$9$k(B1$BHVL\$N<jB3$-$O(B
;term$B$,?tCM$NCM$r$=$N$^$^JV$;$PNI$$!#(Bnext$B$OHO0O$r=g!9$KJV$;$P$$$$$N$G!">e$HF1$8(B

(define (identity x)x)  ; term
(define (sum-integer2 a b)
    (sum identity a inc b))
(print (sum-integer2 2 5))

;pi-sum$B$bF1MM$KDj5A$G$-$k!#(B

(define (pi-term a)(/ 1 (* a (+ a 2))))
(define (pi-next a)(+ a 4))
(define (pi-sum2 a b)
    (sum pi-term a pi-next b))
(print (pi-sum2 2 5))

;(pi-sum$B$N7k2L$,&P(B/8$B$K<}B+$9$k$H$$$&@-<A$rMxMQ$7$F(B)$B!"$3$l$i$N<jB3$-$r(B
;$B;HMQ$7$F!"&P$N6a;wCM$rF@$k$3$H$b$G$-$k!#(B

(print (inexact (* 8 (pi-sum 1 1000))))

;sum$B$H$$$&%F%s%W%l!<%H$,$G$-$?$3$H$G!"$5$i$K35G0$r8x<02=$9$k%S%k%G%#%s%0(B
;$B%V%m%C%/$H$7$F;HMQ=PMh$k!#$?$H$($P!"(Ba$B$+$i(Bb$B$NCM$KBP$9$k4X?t(Bf$B$NE,MQ7k2L$N(B
;$BDj@QJ,(B(definite integral)$B$O2<5-$N8x<0$r;HMQ$7$F!"?tCME*$K$O(Bdx$B$N>.$5$$;~$N(B
;$B6a;wCM$,F@$i$l$k!#(B

;b$B"i(Ba$B!&(Bf = [f(a + dx/2) + f(a + dx + dx/2) + f(a + 2dx + dx/2) + ..]dx

;$BDj@QJ,$N?tCM7W;;(B($BF3F~4X?t$+$i5a$a$k$N$G$O$J$/LL@Q$+$i6a;wCM$rF@$k(B)$B$K$D$$$F$O!"(B
;$BMM!9$J8x<0$,$"$k$,!">e5-$OCfE@K!(B($B@QJ,$9$k6h4V$r(Bd$BEyJ,$7$FD9J}7A$rI_$-5M$a$k$N$@$,!"$=$N9b$5$H$7$F$O(B
;$B6h4V$NCf4VE@(B= (a + dx/2) $B$N$b$N$r;HMQ$9$k(B

;$B?tCM@QJ,(B
;http://ja.wikipedia.org/wiki/%E6%95%B0%E5%80%A4%E7%A9%8D%E5%88%86

(define  (integral f a b dx)
  (define (add-dx x)(+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
    dx))

(print (integral cube 0 1 0.01))
(print (integral cube 0 1 0.001))

;cube$B$N(B0$B$+$i(B1$B$NDj@QJ,$O(B1/4$B$G$"$k(B

;Exercise 1.29
;TODO

;Exercise 1.30
;TODO

;Exercise 1.31
;TODO

;Exercise 1.32
;TODO

;Exercise 1.33
;TODO
