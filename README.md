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
try `make minimal`, `make layer-a`, or `make layer-b`.

Note that "everything" doesn't include `main-distribution` right now.
