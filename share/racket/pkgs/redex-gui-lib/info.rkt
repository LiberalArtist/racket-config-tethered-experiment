(module info setup/infotab (#%module-begin (define collection (quote multi)) (define deps (quote ("scheme-lib" "base" "draw-lib" "gui-lib" "data-lib" "profile-lib" "redex-lib" "redex-pict-lib" "pict-lib"))) (define build-deps (quote ("rackunit-lib"))) (define implies (quote ("redex-lib" "redex-pict-lib"))) (define pkg-desc "implementation (no documentation) part of \"redex\" gui") (define pkg-authors (quote (robby bfetscher)))))