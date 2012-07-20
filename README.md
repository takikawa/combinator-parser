combinator-parser
=================

This is a combinator parser library for [Racket](http://www.racket-lang.org)
that is provided for historical reasons.  The code was previously part of the
Racket distribution but was removed for lack of a maintainer. We recommend
using either
[`parser-tools/yacc`](http://docs.racket-lang.org/parser-tools/Parsers.html?q=parser-tools/yacc)
or other combinator libraries such as
[parseq](http://planet.racket-lang.org/display.ss?package=parseq.plt&owner=bzlib).

For legacy code, the easiest way to get `combinator-parser` working is to
use `raco link`:

  * `git clone git://github.com/takikawa/combinator-parser.git`
  * `cd combinator-parser`
  * `raco link .`

This will install the `combinator-parser` as a collection in your Racket
installation. Thus, all of your `require` statements should work as expected.
