#lang htdp/bsl

; A Price falls into one of three intervals:
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax -1) 0)
(check-expect (sales-tax 999) 0)
(check-expect (sales-tax 9999) (* 0.05 9999))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))

(define (sales-tax p)
  (if (positive? p)
      (cond
        [(and (>= p 0) (< p 1000)) 0]
        [(and (>= p 1000) (< p 10000)) (* 0.05 p)]
        [(>= p 10000) (* 0.08 p)])
      0))
