(module info setup/infotab (#%module-begin (define collection (quote multi)) (define version "1.1") (define deps (quote ("base" "net-lib" ("unix-socket-lib" #:version "1.3") "web-server-lib"))) (define build-deps (quote ("scribble-lib" "net-doc" "racket-doc" "web-server-doc"))) (define pkg-authors (quote (ryanc)))))