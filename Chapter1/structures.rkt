#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)

(define-struct vel [deltax deltay])
(define-struct ball [location velocity])
(define-struct ballf [x y deltax deltay])
(define-struct entry [name phone email])
(define-struct centry (name home office cell))
(define-struct phone (area number))

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))
(define ball2
  (make-ballf 30 40 -10 5))

(vel-deltax (ball-velocity ball1))

(phone-area
 (centry-office
  (make-centry "Shriram Fisler"
               (make-phone 207 "363-2421")
               (make-phone 101 "776-1099")
               (make-phone 208 "112-9981"))))
