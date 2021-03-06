#lang scribble/doc
@(require scribble/manual
          (for-label racket/base
                     readline
                     readline/pread
                     readline/readline
                     racket/contract
                     ffi/unsafe/atomic
                     (except-in ffi/unsafe ->)))

@(define readline "Readline")
@(define Readline "Readline")

@(define foreign-doc '(lib "scribblings/foreign/foreign.scrbl"))

@title{Readline: Terminal Interaction}

The @filepath{readline} collection (not to be confused with Racket's
@racket[read-line] function) provides glue for using the Editline library
or GNU's @|readline|
library with the Racket @racket[read-eval-print-loop].

@margin-note{Due to licensing issues, the @|readline| collection is by default
backed by the Editline library.
To switch to GNU's @|readline| library, either install the
@filepath{readline-gpl} package, or set the @tt{PLT_READLINE_LIB} environment
variable to the library, which configures the @racket[readline] collection to
use @|readline|.}

@section{Normal Use of @|Readline|}

@defmodule*[(readline readline/rep-start)]

The @racketmodname[readline] library installs a @|readline|-based
input port (whose name is @racket['readline-input]) and hooks the
prompt-and-read part of Racket's @racket[read-eval-print-loop] to
interact with it.

You can start Racket with

@commandline{racket -il readline}

or evaluate

@racketblock[
(require readline)
]

in the Racket @racket[read-eval-print-loop] to load @|readline|
manually.  You can also put (require readline) in your
@filepath{~/.racketrc}, so that Racket automatically loads
@|readline| support in interactive mode.

If you want to enable @|readline| support only sometimes---such as
only when you use an @exec{xterm}, and not when you use an Emacs
shell---then you can use @racket[dynamic-require], as in the following
example:

@racketblock[
(when (regexp-match? #rx"xterm"
                     (getenv "TERM"))
  (dynamic-require 'readline #f))
]

The @racketmodname[readline] library automatically checks whether the
current input port is a terminal, as determined by
@racket[terminal-port?], and also checks that its name, as determined
by @racket[object-name], is @racket['stdin], and it installs
@|readline| only to replace the stdin terminal port.  The
@racketmodname[readline/rep-start] module installs @|readline| without
a terminal check.

By default, @|readline|'s completion is set to use the visible
bindings in the current namespace. This is far from ideal, but it's
better than @|readline|'s default filename completion which is rarely
useful.  In addition, the @|readline| history is stored across
invocations in Racket's preferences file, assuming that Racket
exits normally.

The @racketmodname[readline] library adjusts
@racket[read-eval-print-loop] by setting the prompt read handler as
determined by @racket[current-prompt-read]. The call to the read
interaction handler (as determined by
@racket[current-read-interaction]) is parameterized to set
@racket[readline-prompt], so that a prompt will be printed when
reading starts. To compensate for the prompt printed via
@racket[readline-prompt], when the interaction input port's name (as
produced by function in the
@racket[current-get-interaction-input-port] parameter) is
@racket['readline-input], the prompt read handler skips printing a
prompt; otherwise, it displays a prompt as determined by
@racket[current-prompt].

@defproc[(install-readline!) void?]{

Adds @racket[(require readline/rep)] to the result of
@racket[(find-system-path 'init-file)], which is
@filepath{~/.racketrc} on Unix. Consequently, @|readline| will be
loaded whenever Racket is started in interactive mode. The
declaration is added only if it is not already present, as determined
by @racket[read]ing and checking all top-level expressions in the
file.

For more fine-grained control, such as conditionally loading
@|readline| based on an environment variable, edit
@filepath{~/.racketrc} manually.}

@defthing[pre-readline-input-port (or/c input-port? false/c)]{
If required through @racketmodname[readline/rep-start], @racket[pre-readline-input-port] will always
be the input port replaced by the readline input port.

If required through @racketmodname[readline], @racket[pre-readline-input-port] will be an input port
only when the @racket[current-input-port] is actually replaced.
Otherwise, it is @racket[#f].

Using @racket[pre-readline-input-port] is useful for sending the
original stdin to subprocesses.  Subprocesses generally require an
input port backed by a file descriptor, and many interactive programs
behave differently when they have a terminal file descriptor.
Otherwise, @racket[pre-readline-input-port] should not be used, as
reading from it will interfere with the readline port.

@history[#:added "1.1"]}

@section{Interacting with the @|Readline|-Enabled Input Port }

@defmodule[readline/pread]{ The @racketmodname[readline/pread] library
provides customization, and support for prompt-reading after
@racketmodname[readline] installs the new input port.}

The reading facility that the new input port provides can be
customized with the following parameters.


@defparam[current-prompt bstr bytes?]{

A parameter that determines the prompt that is used, as a byte string.
Defaults to @racket[#"> "].}


@;{
@defboolparam[show-all-prompts on?]{

A parameter. If @racket[#f], no prompt is shown until you write input
that is completely readable.  For example, when you type

@racketblock[
(foo bar) (+ 1
             2)
]

you will see a single prompt in the beginning.

The problem is that the first expression can be @racket[(read-line)],
which normally consumes the rest of the text on the @emph{same} line.
The default value of this parameter is therefore @racket[#t], making
it mimic plain I/O interactions.}
}

@defparam[max-history n exact-nonnegative-integer?]{

A parameter that determines the number of history entries to save,
defaults to @racket[100].}


@defparam[keep-duplicates keep? (one-of/c #f 'unconsecutive #t)]{

A parameter. If @racket[#f] (the default), then when a line is equal
to a previous one, the previous one is removed.  If it set to
@racket['unconsecutive] then this happens only for an line that
duplicates the previous one, and if it is @racket[#t] then all
duplicates are kept.}


@defboolparam[keep-blanks keep?]{

A parameter. If @racket[#f] (the default), blank input lines are not
kept in history.}


@defparam[readline-prompt status (or/c false/c bytes? (one-of/c 'space))]{

The new input port that you get when you require
@racketmodname[readline] is a custom port that uses @|readline| for
all inputs.  The problem is when you want to display a prompt and then
read some input, @|readline| will get confused if it is not used when the
cursor is at the beginning of the line (which is why it has a
@racket[_prompt] argument.)  To use this prompt:

@racketblock[
(parameterize ([readline-prompt some-byte-string])
  ...code-that-reads...)
]

This expression makes the first call to @|readline| use the prompt, and
subsequent calls will use an all-spaces prompt of the same length (for
example, when you're reading an S-expression).  The normal value of
@racket[readline-prompt] is @racket[#f] for an empty prompt (and
spaces after the prompt is used, which is why you should use
@racket[parameterize] to restore it to @racket[#f]).

A proper solution would be to install a custom output port, too, which
keeps track of text that is displayed without a trailing newline.  As
a cheaper solution, if line-counting is enabled for the terminal's
output-port, then a newline is printed before reading if the column is
not 0. (The @racketmodname[readline] library enables line-counting
for the output port.)

@bold{Warning:} The @|readline| library uses the output port directly.
You should not use it when @racket[current-input-port] has been
modified, or when it was not a terminal port when Racket was started
(eg, when reading input from a pipe).  Expect some problems if you
ignore this warning (not too bad, mostly problems with detecting an
EOF).}



@section{Direct Bindings for @|Readline| Hackers}

@defmodule[readline/readline]

@defproc[(readline [prompt string?]) string?]{

Prints the given prompt string and reads a line.}


@defproc[(readline-bytes [prompt bytes?]) bytes?]{

Like @racket[readline], but using raw byte-strings for the prompt and
returning a byte string.}


@defproc[(add-history [str string?]) void?]{

Adds the given string to the @|readline| history, which is accessible to
the user via the up-arrow key.}


@defproc[(add-history-bytes [str bytes?]) void?]{

Adds the given byte string to the @|readline| history, which is
accessible to the user via the up-arrow key.}

@defproc[(history-length) exact-nonnegative-integer?]{

Returns the length of the history list.}


@defproc[(history-get [idx integer?]) string?]{

Returns the history string at the @racket[idx] position.  @racket[idx]
can be negative, which will make it count from the last (i.e,
@racket[-1] returns the last item, @racket[-2] returns the
second-to-last, etc.)}


@defproc[(history-delete [idx integer?]) string?]{

Deletes the history string at the @racket[idx] position.  The position
is specified in the same way as the argument for @racket[history-get].}


@defproc[(set-completion-function! [proc ((or/c string? bytes?)
                                          . -> . (listof (or/c string? bytes?)))]
                                   [type (one-of/c _string _bytes) _string])
         void?]{

Sets @|readline|'s @tt{rl_completion_entry_function} to
@racket[proc]. The @racket[type] argument, whose possible values are
from @racketmodname[ffi/unsafe], determines the type of value supplied
to the @racket[proc].

In the CS variant of Racket, @racket[proc] is called in @tech[#:doc
foreign-doc]{atomic mode}.}

@defproc[(set-completion-append-character! [c char?])
         void?]{
Sets @|readline|'s @tt{rl_completion_append_character} to
@racket[c].  The value is reset by the readline library, so it must
be set inside a completion function each time it is called.
The default is @racket[#\space].  Set it to @racket[#\null] to
have no character appended to the completion result.

The @tt{rl_completion_append_character} is used by the readline
library whenever a completion function returns a single option, and it
is therefore chosen.  The choice will be filled in on the command
line, and then the @tt{rl_completion_append_character} is
appended.

As an example, you could set the completion append character to a
slash when completing the name of a directory, a space when you know
the user will want to write another argument, or @racket[#\null] to
avoid appending when a user might want to write something directly
after the completion, such as punctuation or an extension of a word.

If you want to make a completion function to more easily write the
names of your favorite characters (and share your excitement about
them), a use of @racket[set-completion-append-character!] may look
like this:

@racketblock[
(define (christmas-character-complete name-str)
  (set-completion-append-character! #\!)
  (filter (?? (x) (string-prefix? x name-str))
          '("Rudolf" "Hermie" "Bumble" "Yukon" "Clarise" "Santa")))]

@history[#:added "1.1"]}

@defproc[(readline-newline) void?]{

Sets the cursor to the start of a new line.}


@defproc[(readline-redisplay) void?]{

Forces a redisplay of the @|readline| prompt and current user input.

The @racket[readline-redisplay] function can be used together with
@racket[readline-newline] to prevent a background thread from
cluttering up the user input by interleaving its output.  For example,
an unsafe wrapper function for the thread's output might look like the
following:

@racketblock[
(define (with-thread-safe-output output-thunk)
  (dynamic-wind
    (lambda ()
      (start-atomic)
      (readline-newline))
    output-thunk
    (lambda ()
      (readline-redisplay)
      (end-atomic))))]}
