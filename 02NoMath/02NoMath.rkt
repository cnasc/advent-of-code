#lang racket
#|
  To Use: Save your puzzle input as `input.txt` in the `02NoMath` folder, open
  the program in DrRacket, hit run.
|#

;; State, a list of lines and a running total
(struct state(lines total))

;; Definitions
(define (total-sq-feet w)
  (cond [(finished? w) (state-total w)]
        [else (let ([line (car (state-lines w))]
                    [value (calculate line)]
                    [new-world (state (cdr (state-lines w)) (+ (state-total w) value))])
                (total-sq-feet new-world))]
        ))

;; Main
(define (start)
  (define lines (file->lines "input.txt"))
  (define world (state lines 0))
  (total-sq-feet world))

(start)