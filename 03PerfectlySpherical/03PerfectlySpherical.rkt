#lang racket
;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; Represents Santa's list of directions, list of visited positions,
; and current position.
(struct santa (directions visited-posns santa-posn))

; Represents (x, y) coordinates
(struct posn (x y))

;;;;;;;;;;
;; Main ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define w (santa directions (list) (posn 0 0)))
  (visit-houses w))