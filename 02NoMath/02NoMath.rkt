#lang racket
#|
  To Use: Save your puzzle input as `input.txt` in the `02NoMath` folder, open
  the program in DrRacket, hit run.
|#

;; State, a list of lines and a running total
(struct state(lines total))

;; Definitions
; Consumes the state of the world and returns true if no calculations are left
(define (finished? w)
  (empty? (state-lines w)))

; Consumes a line and returns the square feet of wrapping paper it requires
(define (calculate line)
  (print line))

; Consumes the world and returns the total square feet of wrapping paper required
(define (total-sq-feet w)
  (cond [(finished? w) (state-total w)]
        [else (let* ([line (car (state-lines w))]
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