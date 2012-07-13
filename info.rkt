#lang setup/infotab

(define name "Combinator Parser")
(define blurb
  '("A combinator parser library retained for historical
     reasons. Using parser-tools/yacc instead is recommended."))
(define primary-file "main.rkt")
(define categories '(devtools))
(define compile-omit-paths '("examples"))

(define mcfly-planet       'asumu/combinator-parser:1:0)

;; TODO: Add the subtitle string, or define "mcfly-title" instead:
(define mcfly-subtitle     "")

;; TODO: Add the Web home page URL for this package:
(define homepage           "http://!!!")

;; TODO: Add the author(s):
(define mcfly-author       "!!!")

(define repositories       '("4.x"))

(define can-be-loaded-with 'all)

(define scribblings        '(("scribblings/combinator-parser.scrbl" () (library))))

;; TODO: Set this to the file that has starting "doc" forms:
(define mcfly-start        "main.rkt")

;; TODO: Double-check that this includes all files for the PLaneT package:
(define mcfly-files        '(defaults "combinator-unit.rkt"))

;; TODO: Add short name for license (e.g., "LGPLv3"). See http://www.gnu.org/licenses/
(define mcfly-license      "!!!")

;; TODO: Add copyright, license, disclaimers, and other legal information.
(define mcfly-legal        "Copyright !!!")
