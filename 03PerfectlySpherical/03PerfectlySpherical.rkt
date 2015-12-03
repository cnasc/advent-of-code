#lang racket
(require rackunit)

;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; The state of the map, with directions to follow, move counter, and actors
(struct grid (directions counter santa robot) #:transparent)

; The state of an actor, with stops made and current position
(struct actor (stops posn) #:transparent)

; Represents coordinates
(struct posn (x y) #:transparent)

;;;;;;;;;;;;;;;
;; CONSTANTS ;;
;;;;;;;;;;;;;;;
(define UP #\^)
(define DOWN #\v)
(define LEFT #\>)
(define RIGHT #\<)

; Increment for move counter. 1 allows both actors to move, 2 is just Santa
(define INCR 1)

;;;;;;;;;;;;;;;;;;;;;
;; WORLD FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;
; Consumes the grid and produces the grid after all stops are made
(define (make-stops g)
  (cond [(done? g) g]
        [(even? (grid-counter g)) (make-stops (move-santa g))]
        [else (make-stops (move-robot g))]))

; Returns true if no directions remain
(define (done? g)
  (empty? (grid-directions g)))

; Moves santa according to current direction then returns updated grid
(define (move-santa g)
  (define dir (first (grid-directions g)))
  (define santa (grid-santa g))
  (grid (rest (grid-directions g))
        (+ counter INCR)
        (move dir santa)
        (grid-robot g)))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define start-point (posn 0 0))
  (define santa (actor (list start-point) start-point))
  (define robot (actor (list start-point) start-point))
  (define g (grid directions 0 santa robot))
  (grid-directions (make-stops g)))