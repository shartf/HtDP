#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; Posn -> Posn
; represents a state of the world
(define (main p0)
  (big-bang p0
            (on-tick x+)
            ;;(on-mouse reset-dot)
            (to-draw scene+dot)))

; Posn -> Image
; adds a red spot to MTS at p
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

; Posn -> Posn
; increases the x-coordinates of p by 3
(check-expect (x+ (make-posn 10 0))
              (make-posn 13 0))
(define (x+ p)
  ;;(make-posn (+ (posn-x p) 3) (posn-y p))
  (posn-up-x p 3))

;Posn -> Posn
; increases the x-coordinates of Posn p by Number n
(check-expect (posn-up-x (make-posn 10 0) 10)
              (make-posn 20 0))
(define (posn-up-x p n)
  (make-posn (+ (posn-x p) n) (posn-y p)))
