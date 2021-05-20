# racket-config-tethered-experiment
## `test` branch

You should set up `/tmp/config-tethered` as a symlink pointing to this
directory, or just check this repository out there.

Note that you need `--recurse-submodules`.

Run `make` (or `make all`) to build everything, but note that the
[`Makefile`](./Makefile) ***does not track dependencies***. To clean
up, try `git clean -xdi`: some changes may necessitate cleaning in the
`racket/` submodule, too. To re-run a particular step, try `make
minimal`, `make layer-a`, or `make layer-b`.
