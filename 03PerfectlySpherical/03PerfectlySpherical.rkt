#lang racket
;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; Contains a list of directions and two lists of posns
(struct grid (directions santa-posns robot-posns) #:transparent)

; Represents 2D coordinates
(struct posn (x y))