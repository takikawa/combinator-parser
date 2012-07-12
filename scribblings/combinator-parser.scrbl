#lang scribble/manual

@(require planet/scribble
          (for-label racket
                     parser-tools/lex
                     (this-package-in main)))

@title{Combinator Parser}

This documentation provides directions on using the combinator parser
library. It assumes familiarity with lexing and with combinator
parsers. The library was originally developed by Kathy Gray.

@defmodule/this-package[combinator-unit]

This library provides a unit implementing four higher-order functions
that can be used to build a combinator parser, and the export and
import signatures related to it. The functions contained in this unit
automatically build error reporting mechanisms in the event that no
parse is found. Unlike other combinator parsers, this system assumes
that the input is already lexed into tokens using
@racketmodname[parser-tools/lex]. This library relies on
@racketmodname[lazy].

@defthing[combinator-parser-tools unit?]{
  This unit exports the signature
  @racket[combinator-parser^] and imports the signatures
  @racket[error-format-parameters^],
  @racket[language-format-parameters^], and
  @racket[language-dictionary^].
}

@defsignature[combinator-parser^ ()]{

This signature references functions to
build combinators, a function to build a runable parser using a
combinator, a structure for recording errors and macro definitions to
specify combinators with:

@defproc[(terminal [predicate (-> token? boolean?)]
                   [result (-> token? beta)]
                   [name string?]
                   [spell-check (or/c #f (-> token? boolean?)) #f]
                   [case-check (or/c #f (-> token? boolean?)) #f]
                   [type-check (or/c #f (-> token? boolean?)) #f])
         (-> (list/c token?) parser-result)]{
         
  The returned function accepts one terminal from a token stream, and 
  returns produces an opaque value that interacts with other combinators.
}

@defproc[(seq [sequence (listof (-> (list token) parser-result))]
              [result (-> (list alpha) -> beta)]
              [name string?])
         (-> (list token) parser-result)]{
  The returned function accepts a term made up of a sequence of smaller
  terms, and produces an opaque value that interacts with other
  combinators.

  The @racket[sequence] argument is the subterms. The @racket[result]
  argument will create the AST node for this sequence. The input list
  matches the length of the sequence list.

  The @racket[name] argument is the human-language name for this term.
}

@defproc[(choice [options (listof (-> (list token) parser-result))]
                 [name string?])
         (-> (list token) parser-result)]{
 The returned function selects between different terms, and produces an
 opaque value that interacts with other combinators 

 The argument @racket[options] is the list of the possible terms.
 The argument @racket[name] is the human-language name for this term
}

@defproc[(repeat [term (-> (list token) parser-result)])
         (-> (list token) parser-result)]{
  The returned function accepts 0 or more instances of term, and produces
  an opaque value that interacts with other combinators
}

@defproc[(parser [term (-> (list token) parser-result)])
         (-> (list token) (or/c string? editor) (or/c AST err?))]{
    Returns a function that parses a list of tokens, producing either the 
    result of calling all appropriate result functions or an err

    The @racket[location] argument is
     either the string representing the file name or the editor being read,
     typically retrieved from file-path
}
}

@defstruct[err ([msg string?]
                [src (list location integer? integer? integer? integer?)])]{
  The @racket[msg] field contains the error message.

  The @racket[src] field contains the source location for the error
  and is suitable for calling @racket[raise-read-error].
}


@defform/subs[(define-simple-terminals name (simple-spec ...))
              ([simple-spec
                id
                (id string)
                (id proc)
                (id string proc)])]{
    Expands to a define-empty-tokens and one terminal definition per
    simple-spec
    
    The @racket[name] identifier specifies a group of tokens.

    The @racket[id]s specify tokens or terminals with no value. If provided,
    @racket[proc] should be a procedure from tokens to AST nodes. By default,
    the identity function is used. The token will be a symbol.
    If provided, @racket[string] is the human-language name for the terminal,
    @racket[name] is used by default
}

@defform/subs[(define-terminals name (terminal-spec ...))
              ([terminal-spec
                (id proc)
                (id string proc)])]{
   Like @racket[define-simple-terminals], except uses define-tokens.
   
   If provided, @racket[proc] should be a procedure from tokens to AST
   node.  The token will be the token defined as @racket[name] and
   will be a value token.
}

@defform*[[(sequence (name ...) proc string)]]{
  Generates a call to seq with the specified names in a list, 
  proc => result and string => name.
  The name can be omitted when nested in another sequence or choose
  
  If @racket[name] is of the form @racket[(^ id)], it identifies a
  parser production that can be used to identify
  this production in an error message. Otherwise the same as above
}
  
@defform[(choose (name ...) string)]{
  Generates a call to choice using the given terms as the list of options, 
  string => name.
  The name can be omitted when nested in another sequence or choose
}

@defform[(eta name)]{
  Eta expands name with a wrapping that properly mimcs a parser term
}

@defsignature[error-format-parameters^ ()]{
This signature requires five names:

  @itemlist[
    @item{@racket[src?]: @racket[boolean?] - will the lexer include source information}
    @item{@racket[input-type]: @racket[string?] - used to identify the source of input}
    @item{@racket[show-options]: @racket[boolean?] - presently ignored}
    @item{@racket[max-depth]: @racket[integer?] - The depth of errors reported}
    @item{@racket[max-choice-depth]: @racket[integer?] - The max number of options listed in an error}
  ]
}

@defsignature[language-format-parameters^ ()]{
This signature requires two names:

  @itemlist[
    @item{@racket[class-type]: @racket[string?] - general term for language keywords}
    @item{@racket[input->output-name]: @racket[(-> token? string?)] - translates tokens into strings}
  ]
}

@defsignature[language-dictionary^ ()]{
This signature requires three names:

  @itemlist[
  @item{@racket[misspelled]: @racket[(-> string? string? number?)] - 
     check the spelling of the second arg against the first, return a number 
     that is the probability that the second is a misspelling of the first
     }
  @item{@racket[misscap]: @racket[(-> string? string? boolean?)] - 
     check the capitalization of the second arg against the first
     }
  @item{@racket[missclass]: @racket[(-> string? string? boolean?)] - 
     check if the second arg names a correct token kind
     }
  ]
}