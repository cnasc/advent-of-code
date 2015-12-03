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

; Amount by which counter increases during execution.
; `1` allows both actors, `2` just Santa.
(define INCR 1)

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
; Consumes the world and produces the state of the world after all stops are made
(define (make-stops g)
  (define directions (grid-directions g))
  (define counter (grid-counter g))
  (define santa (grid-santa-posns g))
  (define robot (grid-robot-posns g))
  (cond [(empty? directions) g]
        [(even? counter) (make-stops (grid (rest directions)
                                           (+ counter INCR)
                                           (move santa (first directions))
                                           robot))]
        [else (make-stops (grid (rest directions)
                                (+ counter INCR)
                                santa
                                (move robot (first directions))))]))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define santa (list (posn 0 0)))
  (define robot (list (posn 0 0)))
  (define g (grid directions 0 santa robot))
  (length (grid-directions (make-stops g))))