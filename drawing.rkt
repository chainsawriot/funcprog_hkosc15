#lang slideshow
(require 2htdp/image)

;; Will only use few functions
;; we will only draw circle and star today

(circle 20 "outline" "red")
(circle 20 "outline" "red")
(circle 50 "solid" "red")
(circle 40 "solid" (color 255 100 0 255)) ;; color function require R G B, opacity. From 0 to 255

(star 40 "solid" "red")

(overlay (circle 20 "outline" "red") (circle 10 "outline" "blue") (circle 5 "solid" "green"))


(overlay (circle 30 "solid" "blue") (circle 40 "solid" "red") (circle 45 "solid" "white") (circle 50 "solid" "red"))

(overlay (star 30 "solid" "white") (circle 30 "solid" "blue") (circle 40 "solid" "red") (circle 45 "solid" "white") (circle 50 "solid" "red"))

(* 50 0.5)

; identifier

(define chief-executive "Donald Tsang")

; introducing lambda

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

; list

(list 10 20 30 40)

; you can have list of images too

(list (circle 20 "solid" "red") (star 30 "solid" "blue"))

; create a list of shield shields with 20, 50, 90

(list (shield 20) (shield 50) (shield 90))

; key-concept #1: higher order function

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

; immutability - no state!
chief-executive
; You cannot do this again: (define chief-executive "CY Leung")

; Therefore, loops depends on looping variable such as for loop and while loop will not work.

; functional programming rely on higher-order function and recursion to do looping.

(overlay (regular-polygon 20 5 "solid" (make-color  50  50 255))
           (regular-polygon 26 5 "solid" (make-color 100 100 255))
           (regular-polygon 32 5 "solid" (make-color 150 150 255))
           (regular-polygon 38 5 "solid" (make-color 200 200 255))
           (regular-polygon 44 5 "solid" (make-color 250 250 255)))
