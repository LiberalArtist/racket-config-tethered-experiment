(module info setup/infotab (#%module-begin (define collection (quote multi)) (define build-deps (quote ("mzscheme-doc" "draw-doc" "gui-doc" "slideshow-doc" "draw-lib" "gui-lib" "scribble-lib" "slideshow-lib" "pict-lib" "racket-doc" "scribble-doc"))) (define deps (quote ("base"))) (define update-implies (quote ("pict-lib"))) (define pkg-desc "documentation part of \"pict\"") (define pkg-authors (quote (mflatt robby)))))