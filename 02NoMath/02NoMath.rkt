#lang racket
(require rackunit)
#|
  To Use: Save your puzzle input as `input.txt` in the `02NoMath` folder, open
  the program in DrRacket, hit run.
|#

;; State, a list of lines and a running total
(struct state(lines total))

;; Constants
(define SEP "x")

;; Definitions
; Consumes the state of the world and returns true if no calculations are left
(define (finished? w)
  (empty? (state-lines w)))

; Consumes a list representing box dimensions and returns its surface area
(define (surface-area lwh)
  (define l (first lwh))
  (define w (second lwh))
  (define h (third lwh))
  (+ (* 2 l w) (* 2 w h) (* 2 h l)))

; Consumes a list representing box dimensions and returns area of smallest side
(define (smallest-side lwh)
  (define new-list (sort lwh <))
  (* (first new-list) (second new-list)))

; Consumes a line and returns the square feet of wrapping paper it requires
(define (calculate line)
  (define lwh (map string->number (string-split line SEP)))
  (+ (surface-area lwh) (smallest-side lwh)))

; Consumes the world and returns the total square feet of wrapping paper required
(define (total-sq-feet w)
  (cond [(finished? w) (state-total w)]
        [else (let* ([line (car (state-lines w))]
                     [value (calculate line)]
                     [new-world (state (cdr (state-lines w)) (+ (state-total w) value))])
                (total-sq-feet new-world))]))

;; Main
(define (start)
  (define lines (file->lines "input.txt"))
  (define world (state lines 0))
  (total-sq-feet world))

;(start)

;; Tests
(test-case
 "Testing 02NoMath.rkt"
 (check-equal? (surface-area (list 2 3 4)) 52 "Surface area")
 (check-equal? (surface-area (list 2 2 2)) 24 "Surface area")
 (check-equal? (smallest-side (list 2 2 2)) 4 "Smallest side")
 (check-equal? (smallest-side (list 4 2 8)) 8 "Smallest side, mixed order"))