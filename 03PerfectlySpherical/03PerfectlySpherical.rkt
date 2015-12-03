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

; Consumes a list of positions and a direction and produces a list with the
; new position at the head
(define (move lst dir)
  (define head (first lst))
  (define x (posn-x head))
  (define y (posn-y head))
  (cond [(eq? dir UP) (cons (posn x (add1 y)) lst)]
        [(eq? dir DOWN) (cons (posn x (sub1 y)) lst)]
        [(eq? dir LEFT) (cons (posn (sub1 x) y) lst)]
        [(eq? dir RIGHT) (cons (posn (add1 x) y) lst)]
        [else lst]))

; Consumes the final state of the world and returns the results
(define (calculate-results g)
  (define santa (grid-santa-posns g))
  (define robot (grid-robot-posns g))
  (length (remove-duplicates (append santa robot) posn=?)))

; Returns true if two posns are equal
(define (posn=? a b)
  (and (= (posn-x a) (posn-x b))
       (= (posn-y a) (posn-y b))))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define santa (list (posn 0 0)))
  (define robot (list (posn 0 0)))
  (define g (grid directions 0 santa robot))
  (calculate-results (make-stops g)))