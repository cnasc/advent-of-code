#lang racket
;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; Represents Santa's list of directions, list of visited positions,
; and current position.
(struct santa (directions visited-posns cur-posn))

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
  (cond [(done? s) s]
        [else (visit-houses (deliver s))]))

; Checks if Santa has completed his run
(define (done? s)
  (empty? (santa-directions s)))

; Consumes Santa and produces Santa after following a single direction
(define (deliver s)
  (define cur-posn (santa-cur-posn s))
  (define nxt-posn (move (first (santa-directions s)) cur-posn))
  (define remn (rest (santa-directions s)))
  (define visited (santa-visited-posns s))
  (if (member nxt-posn visited)
      (santa remn visited nxt-posn)
      (santa remn (cons nxt-posn visited) nxt-posn)))

; Consumes Santa's current position and direction and produces his position after moving
(define (move direction posn)
  (define x (posn-x posn))
  (define y (posn-y posn))
  (cond [(eq? direction UP) (posn x (add1 y))]
        [(eq? direction DOWN) (posn x (sub1 y))]
        [(eq? direction LEFT) (posn (sub1 x) y)]
        [(eq? direction RIGHT) (posn (add1 x) y)]))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define s (santa directions (list) (posn 0 0)))
  (visit-houses s))