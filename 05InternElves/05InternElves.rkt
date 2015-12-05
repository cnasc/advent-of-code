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
(define vowels (pregexp "[aeiou]"))
(define double-letters (pregexp "([a-z])\\1"))
(define auto-naughty (pregexp "ab|cd|pq|xy"))

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
  (define has-3-vowels (>= (length (regexp-match* vowels str)) 3))
  (define has-double-letter (regexp-match* double-letters str))
  (define naughty (regexp-match auto-naughty str))
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