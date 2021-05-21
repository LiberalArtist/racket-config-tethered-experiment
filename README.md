# racket-config-tethered-experiment

This repository is for sharing my attempt to set up a changed Racket
configuration, as suggested [on the mailing
list](https://groups.google.com/g/racket-dev/c/dHAFwzlFwNA/m/xfVGxIYaAgAJ). See
further discussion at <https://github.com/racket/racket/issues/3834>.

## Usage

You should set up `/tmp/config-tethered` as a symlink pointing to this
directory, or just check this repository out there.

Note that you need `--recurse-submodules`. You may wish to use
`git config --local include.path ../.gitconfig` to enable other
convieniences from the [.gitconfig](./.gitconfig) file.

Run `make` (or `make all`) to build everything, but note that the
[`Makefile`](./Makefile) ***does not track dependencies***. To clean
up, try `git clean -xdi`: some changes may necessitate cleaning in the
`racket/` submodule, too. To re-run a particular step,
try `make minimal`, `make layer-a`, `make layer-b`, or `make main-distribution`.

## Status

  - On Kubuntu 21.04, things get as far as:
    ```
	$ ./main-distribution/bin/plt-games
    standard-module-name-resolver: collection not found
      for module path: (lib "games/main.rkt")
      collection: "games"
      in collection directories:
       /home/philip/.local/share/racket/8.1.0.6/collects
       /tmp/config-tethered/minimal/share/racket/collects/
       /tmp/config-tethered/minimal/share/racket/pkgs/racket-lib
       /tmp/config-tethered/minimal/share/racket/pkgs/base
    ```
  - On Mac OS, `racket/draw/unsafe/glib` fails with the following error,
    which is probably a problem with my local environment:
	```
    raco setup:   ffi-lib: could not load foreign library
    raco setup:     path: libgobject-2.0.0.dylib
    raco setup:     system error: dlopen(libgobject-2.0.0.dylib, 6): Library not loaded: /usr/local/opt/libffi/lib/libffi.6.dylib
    raco setup:     Referenced from: /usr/local/lib/libgobject-2.0.0.dylib
    raco setup:     Reason: image not found
    ```
