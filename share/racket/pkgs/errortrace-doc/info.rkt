(module info setup/infotab (#%module-begin (define collection (quote multi)) (define build-deps (quote ("racket-doc" "base" "errortrace-lib" "scribble-lib"))) (define update-implies (quote ("errortrace-lib"))) (define pkg-desc "documentation part of \"errortrace\"") (define pkg-authors (quote (mflatt robby florence)))))