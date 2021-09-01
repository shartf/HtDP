;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname UFO) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/batch-io)
(require 2htdp/universe)

;; UFO
; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO

(define WIDTH 300) ; distances in terms of pixels
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") MTSCN))

; WorldState -> WorldState
(define (main-ufo y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render]
     [name (ufo-status y0)]))


; WorldState -> WorldState
; computes next location of UFO
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))

; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image UFO (/ WIDTH 2) 11 MTSCN))
(define (render y)
  (place-image UFO (/ WIDTH 2) y MTSCN))

; Number -> String
; converts height to status
(check-expect (ufo-status 34) "descending" )
(check-expect (ufo-status 10) "closing in" )

(check-expect (ufo-status 0) "landed" ) 

(define (ufo-status ht)
  (cond
    [(> ht (* HEIGHT 1/3)) "descending"]
    [(and (<= ht (* HEIGHT 1/3)) (> ht 0)) "closing in"]
    [else "landed"]))

;; test
(main-ufo 10)
