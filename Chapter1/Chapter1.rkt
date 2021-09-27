#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/batch-io)
(require 2htdp/universe)
;; (define x 3)
;; (define y 4)
;; (define (test x y)(sqrt (+ (sqr x) (sqr y))))

;; EX 2
;; (define prefix "hello")
;; (define suffix "world")
;; (string-append prefix "_" suffix)

;; EX 3
;; function which inserts _ in the given place of string
(define str "helloworld")
(define i 5)

(define
  (split-str place-to-split string-to-split)
  (string-append
   (substring string-to-split 0 place-to-split)
   "_"
   (substring string-to-split place-to-split
              (string-length string-to-split))))
  (split-str i str)

;; EX 4
;; create an expression that deletes the ith position from str.
(define
  (cut string-td place-td)
  (string-append
   (substring string-td
              0
              place-td)
   (substring string-td
              (+
               place-td
               1)
              (string-length string-td))))

(define
  (ith-delete string-td place-td)
  (cond
    [(and
      (<
       place-td
       (string-length string-td))
      (>= place-td 0))
     (cut string-td place-td)]
    [(>=
      place-td
      (string-length string-td))
     "Out of index"]
    [(<
      place-td
      0)
     "Cannot be negative"]))

(+ (image-width (circle 10 "solid" "red"))
   (image-height (rectangle 10 20 "solid" "blue")))
;; skipped EX5 and 6 because working with images is pain in emacs. Intend to do it again!
(define sunny #true)
(define friday #false)
(define (mall-checker sunny friday)
  (or
   (not sunny)
   friday))
(mall-checker sunny friday)
(define (inverse-of-x x)
  (if (= x 0) 0 (/ 1 x)))
;; EX 8 skipped becaus too easy and IMAGE AGAIN
;; EX 9
(define in  false)
(define
  (test-in in)
  (cond
    [(number? in) in]
    [(string? in) (string-length in)]
    [(boolean? in) (if (or in false) 10 20)]))

;; EX 11 - done already
;; EX 12
(define
  (cvolume length)
  (* 3 length))

(define
  (csurface length)
  (* 6 (* 2 length)))


;; batch letter
(define (letter fst lst signature-name)
  (string-append
    (opening fst)
    "\n\n"
    (body fst lst)
    "\n\n"
    (closing signature-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))

(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

;; Movie-theater and prices
(define ATTENDANCE (/ 10 0.1)) ;; look mum, a CONSTANT. Like in java.
(define (attendees ticket-price)
  (- 120 (* (- ticket-price 5.0) ATTENDANCE)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* 1.50 (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; FAHRENHEIT
(define (C f)
  (* 5/9 (- f 32)))

(define (convert in out)
  (write-file out
              (string-append
               (number->string
                (C
                 (string->number
                  (read-file in))))
               "\n")))
;; EX 31
(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))
;;(write-file "in-fst.dat" "Maria")
;;(write-file "in-lst.dat" "Holy Ghost")
;;(write-file "in-signature.dat" "Jesus")
;;(main "in-fst.dat" "in-lst.dat" "in-signature.dat" 'stdout)

;; (define (number->square s)
;;   (square s "solid" "red"))
;; (define (reset s ke) 100)
;; (big-bang 100
;;           [to-draw number->square]
;;           [on-tick sub1]
;;           [stop-when zero?]
;;           [on-key reset])

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

(define (main-draw y)
  (big-bang y
            (on-tick sub1)
            (stop-when zero?)
            (to-draw place-dot-at)
            (on-key stop)))

  (define (place-dot-at y)
    (place-image DOT 50 y BACKGROUND))

  (define (stop y ke)
    0)
;; next 3.2 Designing Functions
(define (string-first string)
  (if (string? string)
      (string-ith string 0)
      "Not a string"))

(define (string-last string)
  (if (string? string)
      (string-ith string
                  (- (string-length string) 1))
      "Not a string"))

(define (image-area side)
  (* side side))

(define (string-rest string)
  (if (string? string)
      (substring string 1
                 (string-length string))
      "Not a string"))

(define (string-remove-last string)
  (if (string? string)
      (substring string 0
                 (- (string-length string) 1))
      "Not a string"))

;; next 3.5 Testing
(define (f2c f)
  (* 5/9 (- f 32)))
(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)

;; skipped until 4, because of all the image programming which is not working in emacs properly anyway
(define (next traffic-light-state)
  (cond
    [(string=? "red" traffic-light-state) "green"]
    [(string=? "green" traffic-light-state) "yellow"]
    [(string=? "yellow" traffic-light-state) "red"]))

(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

;; UFO
; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO

;; (define WIDTH 300) ; distances in terms of pixels
;; (define HEIGHT 100)
;; (define CLOSE (/ HEIGHT 3))
;; (define MTSCN (empty-scene WIDTH HEIGHT))
;; (define UFO (overlay (circle 10 "solid" "green") MTSCN))

;; ; WorldState -> WorldState
;; (define (main-ufo y0)
;;   (big-bang y0
;;      [on-tick nxt]
;;      [to-draw ufo/status]
;;      )) ;; TODO STATUS SEEMS NOT TO UPDATE WITH NUMBERS


;; ; WorldState -> WorldState
;; ; computes next location of UFO
;; (check-expect (nxt 11) 14)
;; (define (nxt y)
;;   (+ y 3))

;; ; WorldState -> Image
;; ; places UFO at given height into the center of MTSCN
;; (check-expect (render 11) (place-image UFO (/ WIDTH 2) 11 MTSCN))
;; (define (render y)
;;   (place-image UFO (/ WIDTH 2) y MTSCN))

;; ; WorldState -> Image
;; ; converts height to status
;; (check-expect (ufo/status 10)
;;               (place-image (text "descending" 11 "green")
;;                            10 10
;;                            (render 10)))

;; (define (ufo/status ht)
;;   (place-image
;;    (cond
;;      [(<= 0 ht CLOSE) (text "descending" 11 "green")]
;;      [(and (< CLOSE ht) (<= ht HEIGHT)) (text "closing in" 11 "orange")]
;;      [(> ht HEIGHT) (text "landed" 11 "reg")])
;;     20 20
;;     (render ht)))

;;(main-ufo 0)

;; 1: define constants
; ROCKET
(define HEIGHT 300)
(define WIDTH 100)
(define YDELTA 3)
(define BACKG (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define CENTER (/ (image-height ROCKET) 2))

;; 2: write a data definition
; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

;; 3: Write function skeletons
; LRCD -> Image
; renders the state as a resting or flying rocket
(define (show x)
  (cond
    [(string? x)
     (place-rocket HEIGHT)]
    [(<= 3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket HEIGHT))]
    [(>= x 0)
     (place-rocket x)]))

; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed,
; if the rocket is still resting
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)


(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

;; 4: Write tests
(check-expect
 (show "resting")
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 HEIGHT BACKG)))

(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 CENTER) BACKG))

;; 5: Write auxillary functions
(define (place-rocket height)
  (place-image ROCKET 10 (- height CENTER) BACKG))

(define (gone s)
  (cond
    [(and (number? s) (= s 0)) #t]
    [else #f]))

;; 6: main function
; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]))

(define (main2 s)
  (big-bang s
            (on-tick fly 0.3)
            (to-draw show)
            (on-key launch)
            (close-on-stop #t)
            (stop-when gone)))
