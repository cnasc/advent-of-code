#| Advent of Code 01: Not Quite Lisp
 |
 | Santa is trying to deliver presents in a large apartment building, but he
 | can't find the right floor - the directions he got are a little confusing.
 | He starts on the ground floor (floor 0) and then follows the instructions one
 | character at a time.
 |
 | An opening parenthesis, (, means he should go up one floor, and a closing
 | parenthesis, ), means he should go down one floor.
|#

#lang racket
(require rackunit)

;; State
(struct directions (list floor))

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

;; Tests
; up?
(check-eq? (up? #\() #t "Open parenthesis means up")
(check-eq? (up? #\)) #f "Close paren means down")
(check-eq? (up? #\5) #f "Non paren values should be false")
; down?
(check-eq? (down? #\)) #t "Close paren means down")
(check-eq? (down? #\() #f "Open parenthesis means up")
(check-eq? (down? #\5) #f "Non paren values should be false")

