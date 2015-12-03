#lang racket
;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; Represents Santa's list of directions, list of visited positions,
; and current position.
(struct santa (directions visited-posns santa-posn))

; Represents (x, y) coordinates
(struct posn (x y))

;;;;;;;;;;;;;;;
;; CONSTANTS ;;
;;;;;;;;;;;;;;;
; Directions Santa can move in
(define UP #\^)
(define DOWN #\v)
(define LEFT #\<)
(define RIGHT #\>)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SANTA RELATED FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Consumes Santa and produces Santa after following all directions
(define (visit-houses s)
  )

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define s (santa directions (list) (posn 0 0)))
  (visit-houses s))