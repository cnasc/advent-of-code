#| Advent of Code 01: Not Quite Lisp
 |
 | Santa is trying to deliver presents in a large apartment building, but he
 | can't find the right floor - the directions he got are a little confusing.
 | He starts on the ground floor (floor 0) and then follows the instructions one
 | character at a time.
 |
 | An opening parenthesis, (, means he should go up one floor, and a closing
 | parenthesis, ), means he should go down one floor.
 |
 | TO USE: Open in DrRacket and hit run, enter string of directions into prompt.
|#

#lang racket
(require rackunit)

;; State
(struct directions (list floor) #:transparent)

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
; Consumes the state of the world and returns which floor Santa should go to
(define (find-floor w)
  (define list (directions-list w))
  (define floor (directions-floor w))
  (cond [(empty? list) floor]
        [(up? (car list)) (find-floor (directions (cdr list) (add1 floor)))]
        [(down? (car list)) (find-floor (directions (cdr list) (sub1 floor)))]
        [else (find-floor (directions (cdr list) floor))]))

;; Main
(define (start)
  ; Read in a line to get directions, split into list, pass into struct
  (define state (directions (string->list (read-line)) 0))
  (find-floor state))

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
; find-floor
(check-eq? (find-floor (directions (list UP UP) 0)) 2 "Two ups should yield floor 2")
(check-eq? (find-floor (directions (list DOWN DOWN) 0)) -2 "Two downs should yield floor -2")
(check-eq? (find-floor (directions (list) 0)) 0 "An empty list should yield floor 0")
(check-eq? (find-floor (directions (list #\p #\k #\!) 0)) 0 "A list of invalid moves should yield floor 0")

