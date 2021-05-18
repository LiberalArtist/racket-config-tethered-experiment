#lang racket/base

(require program-a)

(define b
  (list 'b a))

(module+ main
  (require racket/cmdline)
  (command-line
   #:args ()
   (printf "program: ~v\n" b)))
