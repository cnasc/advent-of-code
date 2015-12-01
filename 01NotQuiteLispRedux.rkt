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

;; Main
(define (start)
  ; Read in a line to get directions, split into list, pass into struct
  (define state (directions (string->list (read-line)) 0 1))
  (print state))

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

