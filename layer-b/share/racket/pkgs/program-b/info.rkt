#lang info

(define collection "program-b")
(define racket-launcher-names
  (list collection))
(define racket-launcher-libraries
  '("main.rkt"))
(define deps '("base" "program-a"))
(define build-deps '())
(define scribblings '())
(define pkg-desc "Demo for tethering")
(define version "0.0")
(define pkg-authors '(philip))
