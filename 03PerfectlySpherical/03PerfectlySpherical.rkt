#lang racket
(require rackunit)

;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; The state of the map, with directions to follow and actors
(struct grid (directions santa robot) #:transparent)

; The state of an actor, with stops made and current position
(struct actor (stops posn) #:transparent)

; Represents coordinates
(struct posn (x y) #:transparent)

;;;;;;;;;;;;;;;;;;;;;
;; WORLD FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define start-point (posn 0 0))
  (define santa (actor (list start-point) start-point))
  (define robot (actor (list start-point) start-point))
  (define g (grid directions santa robot))
  (grid-directions (make-stops g)))