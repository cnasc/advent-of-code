#lang racket
#|
Santa needs help figuring out which strings in his text file are naughty or nice.

A nice string is one with all of the following properties:
    -It contains at least three vowels (aeiou only), like aei, xazegov, or
     aeiouaeiouaeiou.
    -It contains at least one letter that appears twice in a row, like xx,
     abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
    -It does not contain the strings ab, cd, pq, or xy, even if they are part
     of one of the other requirements.
|#

;;;;;;;;;;;;;;;
;; CONSTANTS ;;
;;;;;;;;;;;;;;;
; Year 1
(define VOWELS (pregexp "[aeiou]"))
(define DOUBLE-LETTERS (pregexp "([a-z])\\1"))
(define AUTO-NAUGHTY (pregexp "ab|cd|pq|xy"))

; Year 2
(define TWO-PAIRS (pregexp "\\w*?(\\w{2})\\w*?\\1"))
(define SPLIT (pregexp "(\\w).\\1"))

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
; Consumes an input list and accumulator, produces number of nice strings
(define (number-of-nice-strings input acc)
  (cond [(empty? input) acc]
        [(nice? (car input)) (number-of-nice-strings (cdr input) (add1 acc))]
        [else (number-of-nice-strings (cdr input) acc)]))

; Returns true if a string meets niceness requirements
(define (nice? str)
  (define has-3-vowels (>= (length (regexp-match* VOWELS str)) 3))
  (define has-double-letter (regexp-match DOUBLE-LETTERS str))
  (define naughty (regexp-match AUTO-NAUGHTY str))
  (if (and (not naughty)
           has-3-vowels
           has-double-letter)
      #t
      #f))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start file-name)
  (define input (file->lines file-name))
  (number-of-nice-strings input 0))