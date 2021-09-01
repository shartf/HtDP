#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)

;; Chapter 1, exercise 59
;; Works fine, but I am not amazed by my code. There should be a better way, with one generic function for all states of the Traffic light.
;; But I don't see it producing less code. Also, the way I've defined my TL is ugly and maybe backwards, but I can't see the alternative take being better.
;; Certainly, I am missing something.

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
; TESTS
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "red") "green")
(define (tl-next cs)
  (cond
    [(string=? cs "green") "yellow"]
    [(string=? cs "yellow") "red"]
    [(string=? cs "red") "green"]))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "green") (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "outline" "yellow")
            30 0
            (circle 10 "solid" "green"))
        -45 0
        (circle 10 "outline" "red"))
    0 0
    (empty-scene 90 30)))
(check-expect (tl-render "yellow") (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "solid" "yellow")
            30 0
            (circle 10 "outline" "green"))
        -45 0
        (circle 10 "outline" "red"))
    0 0
    (empty-scene 90 30)))
(check-expect (tl-render "red") (overlay/offset
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
    [(string=? current-state "green") (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "outline" "yellow")
            30 0
            (circle 10 "solid" "green"))
        -45 0
        (circle 10 "outline" "red"))
    0 0
    (empty-scene 90 30))]
    [(string=? current-state "yellow") (overlay/offset
  (overlay/offset
        (overlay/offset
            (circle 10 "solid" "yellow")
            30 0
            (circle 10 "outline" "green"))
        -45 0
        (circle 10 "outline" "red"))
    0 0
    (empty-scene 90 30))]
    [(string=? current-state "red") (overlay/offset
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
            (on-tick tl-next 3)))

;; (underlay
;;  (place-image (circle 10 "outline" "red") 15 15 (empty-scene 90 30))
;;  (place-image (circle 10 "outline" "yellow") (+ 15 30) 15 (empty-scene 90 30))
;;  (place-image (circle 10 "outline" "green") (+ 15 60) 15 (empty-scene 90 30)))


(place-images/align
 (list (circle 10 "outline" "red")
       (circle 10 "outline" "yellow")
       (circle 10 "outline" "green"))
 (list (make-posn 5 4)
       (make-posn 35 4)
       (make-posn 65 4))
 "left" "top"
 (empty-scene 90 30))
