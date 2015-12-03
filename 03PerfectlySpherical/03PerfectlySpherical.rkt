#lang racket
;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; Contains a list of directions, a move counter, and two lists of posns
(struct grid (directions counter santa-posns robot-posns) #:transparent)

; Represents 2D coordinates
(struct posn (x y) #:transparent)

;;;;;;;;;;;;;;;
;; CONSTANTS ;;
;;;;;;;;;;;;;;;
(define UP #\^)
(define DOWN #\v)
(define LEFT #\<)
(define RIGHT #\>)

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define santa (list (posn 0 0)))
  (define robot (list (posn 0 0)))
  (define g (grid directions 0 santa robot))
  (length (grid-directions (make-stops g))))