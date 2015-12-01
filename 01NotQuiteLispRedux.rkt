#| Advent of Code 01: Not Quite Lisp Part Two
 |
 | Now, given the same instructions, find the position of the first character
 | that causes him to enter the basement (floor -1). The first character in the
 | instructions has position 1, the second character has position 2, and so on.
 |
 | TO USE: Open in DrRacket and hit run, enter string of directions into prompt.
|#

#lang racket
(require rackunit)

;; State
(struct directions (list floor position) #:transparent)

;; Constants
(define UP #\()
(define DOWN #\))

;; Definitions
; Consumes a character and returns true if it means up, false otherwise
(define (up? char)
  (equal? char UP))
; Consumes a character and returns true if it means down, false otherwise
(define (down? char)
  (equal? char DOWN))
; Consumes the state of the world and returns the first position where Santa enters the basement
(define (basement-position w)
  (define list (directions-list w))
  (define floor (directions-floor w))
  (define position (directions-position w))
  (cond [(and (empty? list) (not (negative? floor))) 0] ; never found a basement position
        [(negative? floor) position] ; return position of first time floor goes negative
        [(up? (car list)) (basement-position (directions (cdr list) (add1 floor) (add1 position)))]
        [(down? (car list)) (basement-position (directions (cdr list) (sub1 floor) (add1 position)))]
        [else (basement-position (cdr list) floor position)]))

;; Main
(define (start)
  ; Read in a line to get directions, split into list, pass into struct
  (define state (directions (string->list (read-line)) 0 0))
  (basement-position state))

(start)

;; Tests
; up?
(check-eq? (up? #\() #t "Open parenthesis means up")
(check-eq? (up? #\)) #f "Close paren means down")
(check-eq? (up? #\5) #f "Non paren values should be false")
; down?
(check-eq? (down? #\)) #t "Close paren means down")
(check-eq? (down? #\() #f "Open parenthesis means up")
(check-eq? (down? #\5) #f "Non paren values should be false")
; basement-position
(check-eq? (basement-position (directions (list UP UP DOWN DOWN DOWN) 0 0)) 5)
(check-eq? (basement-position (directions (list DOWN DOWN DOWN) 0 0)) 1)
(check-eq? (basement-position (directions (list UP UP DOWN DOWN) 0 0)) 0)
(check-eq? (basement-position (directions (list UP UP) 0 0)) 0)