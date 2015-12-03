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

