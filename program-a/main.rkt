#lang racket/base

(provide a)

(define a 'a)

(module+ main
  (require racket/cmdline)
  (command-line
   #:args ()
   (printf "program: ~v\n" a)))
