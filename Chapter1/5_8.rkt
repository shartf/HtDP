#lang htdp/bsl
(require 2htdp/universe)

(define-struct r3 (x y z))
; An R3 is a structure:
; (make-r3 Number Number Number)

(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; R3 -> Number
; determines the distance of p to the origin
;(check-expect (r3-distance-to-0 ex1) 13.19090595827292)
;(check-expect (r3-distance-to-0 ex2) 3.1622776601683795)

(define (r3-distance-to-0 p)
  (sqrt (+  (sqr (r3-x p))
         (sqr (r3-y p))
         (sqr (r3-z p)))))

; EXERCISE 81
(define-struct time (h m s))
; Time structure
; (make-time Number Number Number)
(define t1 (make-time 12 30 2))

; Time -> Seconds
; Consumes a time structure and returns a number of seconds passed since midnight
(check-expect (time->seconds t1) 45002)

(define (time->seconds t)
  (+ (time-s t)
     (* (time-m t) 60)
     (* (time-h t) 3600)))

; EXERCISE 82
(define-struct 3-word (1st 2nd 3rd))
; Word structure
; (make 3-word Character Character Character)
(define word1 (make-3-word "a" "b" "c"))
(define word2 (make-3-word "c" "d" "e"))
(define word3 (make-3-word "c" "b" "d"))

; 3-Word (Character Character Character) -> 3-Word (Bool Bool Bool)
; Returns a 3-word with boolean fields for comparison
(check-expect (compare-word word1 word1) (make-3-word #t #t #t))
(check-expect (compare-word word1 word2) (make-3-word #f #f #f))
(check-expect (compare-word word1 word3) (make-3-word #f #t #f))

(define (compare-word w1 w2)
  (make-3-word
   (cond [(eq? (3-word-1st w1) (3-word-1st w2)) #t] [else #f])
   (cond [(eq? (3-word-2nd w1) (3-word-2nd w2)) #t] [else #f])
   (cond [(eq? (3-word-3rd w1) (3-word-3rd w2)) #t] [else #f])))
