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
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
(define (number-of-nice-strings input acc)
  (cond [(empty? input) acc]
        [(nice? (car input)) (number-of-nice-strings (cdr input) (add1 acc))]
        [else (number-of-nice-strings (cdr input) acc)]))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start file-name)
  (define input (file->lines file-name))
  (number-of-nice-strings input 0))