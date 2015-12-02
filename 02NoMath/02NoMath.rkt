#lang racket
(require rackunit)
#|
  To Use: Save your puzzle input as `input.txt` in the `02NoMath` folder, open
  the program in DrRacket, hit run.
|#

;; State, a list of lines and a running total
(struct state(lines paper ribbon))

;; Constants
; The separator for values in input file
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

; Consumes list representing box dimensions and returns the smallest perimeter
(define (smallest-perimeter lwh)
  (define new-list (sort lwh <))
  (+ (* 2 (first new-list)) (* 2 (second new-list))))

; Consumes list representing box dimensions and returns the cubic volume
(define (cubic-volume lwh)
  (* (first lwh) (second lwh) (third lwh)))

; Consumes a list representing box dimensions and returns the length of ribbon it requires
(define (ribbon-amt lwh)
  (+ (smallest-perimeter lwh) (cubic-volume lwh)))

; Consumes a list representing box dimensions and returns the square feet of wrapping paper it requires
(define (paper-amt lwh)
  (+ (surface-area lwh) (smallest-side lwh)))

; Consumes the world and returns the square feet of paper required and the length of ribbon required
(define (total-materials w)
  (cond [(finished? w) (list (state-paper w) (state-ribbon w))]
        [else (let* ([line (car (state-lines w))]
                     [lwh (map string->number (string-split line SEP))]
                     [paper-val (paper-amt lwh)]
                     [ribbon-val (ribbon-amt lwh)]
                     [new-world (state (cdr (state-lines w))
                                       (+ (state-paper w) paper-val)
                                       (+ (state-ribbon w) ribbon-val))])
                (total-materials new-world))]))

;; Main
(define (start)
  (define lines (file->lines "input.txt"))
  (define world (state lines 0 0))
  (define answers (total-materials world))
  (print answers))

;(start)

;; Tests
(test-case
 "Testing 02NoMath.rkt"
 (check-equal? (surface-area (list 2 3 4)) 52 "Surface area")
 
 (check-equal? (smallest-side (list 2 3 4)) 6 "Smallest side")
 (check-equal? (smallest-side (list 4 2 8)) 8 "Smallest side, mixed order")

 (check-equal? (smallest-perimeter (list 2 3 4)) 10 "Smallest perimeter")
 (check-equal? (smallest-perimeter (list 6 8 4)) 20 "Smallest perimeter, mixed order"))