#lang racket
(require 2htdp/image)

;; Will only use few functions
;; we will only draw circle and star today

;; big idea #1: prefix notation - except 'special form'
;; (function-name argument1 argument2 ...)
;; use that function and return something

(circle 20 "outline" "red")
(circle 20 "outline" "red")
(circle 50 "solid" "red")
(circle 40 "solid" (make-color 255 100 0 255)) ;; make-color function require R G B, opacity. From 0 to 255

(star 40 "solid" "red")

(overlay (circle 20 "outline" "red") (circle 10 "outline" "blue") (circle 5 "solid" "green"))

(overlay (circle 30 "solid" "blue") (circle 40 "solid" "red") (circle 45 "solid" "white") (circle 50 "solid" "red"))

(overlay (star 30 "solid" "white") (circle 30 "solid" "blue") (circle 40 "solid" "red") (circle 45 "solid" "white") (circle 50 "solid" "red"))

;; basic calculation, we used to infix notation like: 50 * 0.5, but in Lisp, everything expression must be 
;; express in prefix notation.

(* 50 0.5)
(- 100 20 30)
(+ 100 50 20)

;; and guess what is the output of these?

(/ 3 2)
(/ 3 2.0)

; identifier - avoid the terminology of 'variable' for now.
; define is the first 'special form', the second argument is not eval, only generate a binding

(define chief-executive "Donald Tsang")
chief-executive

; Big-idea #2: introducing lambda

(lambda () "Hello World") ; you can use Ctrl + \ to insert a λ, second argument is the parameter
(λ () "Hello World")

; call that anonymous function

((λ () "Hello World"))


((λ (x) (* x 0.5)) 10)

; named function - use define to add label

(define half (λ (x) (* x 0.5)))
(half 30)

; synatic sugar form

(define (half2 x) (* x 0.5))
(half2 100)
(half2 80)

; define a function called captain-test with no argument to draw a shield

(define (captain-test)
  (overlay (star 30 "solid" "white")
           (circle 30 "solid" "blue")
           (circle 40 "solid" "red")
           (circle 45 "solid" "white")
           (circle 50 "solid" "red")))

(captain-test)

; define another function called 'shield' with one argument of 'size' to draw the shield with different size
; size spec:
; inner white circle = size * 0.9, 
; inner red circle = size * 0.8
; inner blue circle and star = size * 0.6

(define (shield size)
  (overlay (star (* size 0.6) "solid" "white")
           (circle (* size 0.6) "solid" "blue")
           (circle (* size 0.8) "solid" "red")
           (circle (* size 0.9) "solid" "white")
           (circle size "solid" "red")))

(shield 400)

; Big-idea #3: abstraction, building abstraction, so that you don't need to deal with the inner working of the function.

; list

(list 10 20 30 40)

; you can have list of images too

(list (circle 20 "solid" "red") (star 30 "solid" "blue"))

; create a list of shield shields with 20, 50, 90

(list (shield 20) (shield 50) (shield 90))

; Big-idea #4: higher order function
; func - 1) take function(s) as argument
;      - 2) return another function

; higher order function #1: map

(map shield (list 20 50 90))

; you can use anonymous function too!

(map (λ (x) (circle x "outline" "red")) (list 10 20 30 40 50 60 70 80 90))

; higher order function #2: reduce - or left-fold foldl

(foldl - 0 (list 100 20 10))

(foldl + 0 (list 1 2 3 4 5 6 7 8 9))

; Now you know what is map-reduce

empty-image

(foldl overlay empty-image (map (λ (x) (circle x "outline" "red")) (list 10 20 30 40 50 60 70 80 90)))

; why higer-order function - elimination of loop and state

; Big-idea #5: immutability - no state!
chief-executive
; You cannot do this again: (define chief-executive "CY Leung")

; Therefore, loops depends on looping variable such as for loop and while loop will not work.
; No 'side-effect' such as looping variable

; functional programming rely on higher-order function and recursion to do looping.

; boolean

(define ten 10)

; remember, prefix notation, not: ten > 12

(> ten 12)
(= ten 10)

; condition: cond, another special-form

(if (= ten 10) "Logical" "Not-logical")

; predicate - function that return bool

(if (zero? 0) "Nothing" "Still something")
(if (zero? 100) "Nothing" "Still something")

(if (image? (shield 100)) "It is a image" "I need some image")

(beside (shield 100) (shield 80))

(beside (shield 100) (beside (shield 80) (shield 60)))

; base case
; recursive case

(define (lot-of-shields size)
  (if (< size 20)
      empty-image
      (beside (shield size) (lot-of-shields (- size 20)))))

(lot-of-shields 300)
;(save-image (lot-of-shields 300) "stupid.png")

(or (= ten 10) (> ten 100))

(overlay (circle 40 "solid" (make-color 0 0 255)) (circle 50 "solid" (make-color 100 100 255)))

; define a recursive function to make a smooth color circle

(define (smooth-circle size depth)
  (if (or (< size 10) (= 255 depth)) 
      empty-image
      (overlay (smooth-circle (- size 1) (+ depth 5)) (circle size "solid" (make-color depth depth 255)))))

(smooth-circle 40 0)

(define (smooth fn size depth)
  (if (or (< size 10) (= 255 depth)) 
      empty-image
      (overlay (smooth fn (- size 1) (+ depth 5)) (fn size "solid" (make-color depth depth 255)))))

;; any fuction with the same arity to circle should work

(smooth circle 40 0)
(smooth star 40 0)
(smooth triangle 100 0)

;; 'flatten' a function with different arity by creating an anonymous function

(smooth (λ (size style color) (regular-polygon size 7 style color)) 50 0)

;; create another form of higher order function - a function that create another function

(define (npolygon n)
  (λ (size style color) (regular-polygon size n style color)))

(npolygon 10)

((npolygon 10) 60 "solid" "blue")
((npolygon 8) 60 "solid" "blue")

(smooth (npolygon 10) 50 0)

(smooth (npolygon 3) 50 0)

(map (λ (n) (smooth (npolygon n) 50 0)) (list 3 4 5 6 7 8 9 10))

; the fourth property of first-class function: member of an aggregate (e.g. list)

(list circle star (npolygon 10))

(map (λ (fn) (smooth fn 50 0)) (list circle star (npolygon 10)))

; currying: making a function with multiple arguments into multiple (partial) functions with single argument

(curry smooth) ; return a curried version of the smooth function

((((curry smooth) circle) 40) 0)

; why curry? because higher order functions usually require function with single argument.
; can be useful sometime, but I prefer writing anonymous function. (Yes, I am an R programmer)

(map (((curry smooth) circle) 40) (list 0 50 100))

(map (λ (depth) (smooth circle 40 depth)) (list 0 50 100))

