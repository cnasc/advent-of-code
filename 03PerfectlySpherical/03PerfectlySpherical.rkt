#lang racket
;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; Represents the world as a list of directions, list of visited positions,
; and Santa's current position.
(struct world (directions visited-posns santa-posn))

; Represents (x, y) coordinates
(struct posn (x y))

;;;;;;;;;;
;; Main ;;
;;;;;;;;;;