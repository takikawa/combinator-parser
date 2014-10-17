combinator-parser
=================

This is a combinator parser library for [Racket](http://www.racket-lang.org)
that is provided for historical reasons.  The code was previously part of the
Racket distribution but was removed for lack of a maintainer. We recommend
using either
[`parser-tools/yacc`](http://docs.racket-lang.org/parser-tools/Parsers.html?q=parser-tools/yacc)
or other parsing packages such as [parsack](http://pkg-build.racket-lang.org/doc/parsack/index.html)
or [ragg](http://hashcollision.org/ragg/).

For legacy code, the easiest way to get `combinator-parser` working is to
use `raco pkg` if you have Racket v5.3.2 or newer:

  * `raco pkg install combinator-parser`

For older versions of Racket, try the following:

  * `git clone git://github.com/takikawa/combinator-parser.git`
  * `cd combinator-parser/combinator-parser`
  * `raco link .`

This will install `combinator-parser` as a collection in your Racket
installation. Thus, all of your `require` statements should work as expected.
