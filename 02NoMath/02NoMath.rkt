#lang racket
#|
  To Use: Save your puzzle input as `input.txt` in the `02NoMath` folder, open
  the program in DrRacket, hit run.
|#

;; State, a list of lines and a running total
(struct state(lines total))

;; Definitions
(define (total-sq-feet w)
  (define line (car (state-lines w)))
  (print line))

;; Main
(define (start)
  (define lines (file->lines "input.txt"))
  (define world (state lines 0))
  (total-sq-feet world))

(start)