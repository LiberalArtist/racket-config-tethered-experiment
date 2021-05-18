#hash((lib-dir . "/tmp/config-tethered/layer-b/lib/racket")
      (lib-search-dirs
       . (#f
          "/tmp/config-tethered/layer-a/lib/racket"
          "/tmp/config-tethered/minimal/lib/racket"))
      (share-dir . "/tmp/config-tethered/layer-b/share/racket")
      (share-search-dirs
       . (#f
          "/tmp/config-tethered/layer-a/share/racket"
          "/tmp/config-tethered/minimal/share/racket"))
      (links-file . "/tmp/config-tethered/layer-b/share/racket/links.rktd")
      (links-search-files
       . (#f
          "/tmp/config-tethered/layer-a/share/racket/links.rktd"
          "/tmp/config-tethered/minimal/share/racket/links.rktd"))
      (pkgs-dir . "/tmp/config-tethered/layer-b/share/racket/pkgs")
      (pkgs-search-dirs
       . (#f
          "/tmp/config-tethered/layer-a/share/racket/pkgs"
          "/tmp/config-tethered/minimal/share/racket/pkgs"))
      ;; TODO: compiled-file-roots: use lib/
      (compiled-file-roots
       . (same
          "/tmp/config-tethered/minimal/lib/racket/compiled"))
      (bin-dir . "/tmp/config-tethered/bogus-unused-bin-dir-b")
      (bin-search-dirs
       . (#f
          ;; ??? Is this correct ???
          "/tmp/config-tethered/bogus-unused-bin-dir-a"
          "/tmp/config-tethered/minimal/bin"))
      (apps-dir . "/tmp/config-tethered/layer-b/share/applications")
      ;; NOTE `no @racket['apps-dir] search needed`
      (man-dir . "/tmp/config-tethered/layer-b/share/man")
      (man-search-dirs
       . (#f
          "/tmp/config-tethered/layer-a/share/man"
          "/tmp/config-tethered/minimal/share/man"))
      (doc-dir . "/tmp/config-tethered/layer-b/share/doc/racket")
      (doc-search-dirs
       . (#f
          "/tmp/config-tethered/layer-a/share/doc/racket"
          "/tmp/config-tethered/minimal/share/doc/racket"))
      (include-dir . "/tmp/config-tethered/layer-b/include/racket")
      (include-search-dirs
       . (#f
          "/tmp/config-tethered/layer-a/include/racket"
          "/tmp/config-tethered/minimal/include/racket"))
      (absolute-installation? . #t)
      (config-tethered-console-bin-dir . "/tmp/config-tethered/layer-b/bin")
      )

