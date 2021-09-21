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

;EXERCISE 80
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
