#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)

;; Chapter 1, exercise 59
;; Works fine, but I am not amazed by my code. There should be a better way, with one generic function for all states of the Traffic light.
;; But I don't see it producing less code. Also, the way I've defined my TL is ugly and maybe backwards, but I can't see the alternative take being better.
;; Certainly, I am missing something.


; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))


; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render 1) (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "outline" "yellow")
            30 0
            (circle 10 "solid" "green"))
        -45 0
        (circle 10 "outline" "red"))
    0 0
    (empty-scene 90 30)))
(check-expect (tl-render 2) (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "solid" "yellow")
            30 0
            (circle 10 "outline" "green"))
        -45 0
        (circle 10 "outline" "red"))
    0 0
    (empty-scene 90 30)))
(check-expect (tl-render 0) (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "outline" "yellow")
            30 0
            (circle 10 "outline" "green"))
        -45 0
        (circle 10 "solid" "red"))
    0 0
  (empty-scene 90 30)))

;; IMPLEMENTATION
(define (tl-render current-state)
  (cond
    [(= current-state 1) (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "outline" "yellow")
            30 0
            (circle 10 "solid" "green"))
        -45 0
        (circle 10 "outline" "red"))
    0 0
    (empty-scene 90 30))]
    [(= current-state 2) (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "solid" "yellow")
            30 0
            (circle 10 "outline" "green"))
        -45 0
        (circle 10 "outline" "red"))
    0 0
    (empty-scene 90 30))]
    [(= current-state 0) (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "outline" "yellow")
            30 0
            (circle 10 "outline" "green"))
        -45 0
        (circle 10 "solid" "red"))
    0 0
  (empty-scene 90 30))]))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            (to-draw tl-render)
            (on-tick tl-next-numeric 3)))

;; (underlay
;;  (place-image (circle 10 "outline" "red") 15 15 (empty-scene 90 30))
;;  (place-image (circle 10 "outline" "yellow") (+ 15 30) 15 (empty-scene 90 30))
;;  (place-image (circle 10 "outline" "green") (+ 15 60) 15 (empty-scene 90 30)))


;; (place-images/align
;;  (list (circle 10 "outline" "red")
;;        (circle 10 "outline" "yellow")
;;        (circle 10 "outline" "green"))
;;  (list (make-posn 5 4)
;;        (make-posn 35 4)
;;        (make-posn 65 4))
;;  "left" "top"
;;  (empty-scene 90 30))
