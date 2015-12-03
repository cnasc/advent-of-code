#lang racket
(require rackunit rackunit/text-ui)
;;;;;;;;;;
;; DATA ;;
;;;;;;;;;;
; Represents Santa's list of directions, list of visited positions,
; current position, and position of Robo-Santa.
(struct santa (directions visited-posns cur-posn robo-posn) #:transparent)

; Represents (x, y) coordinates
(struct posn (x y) #:transparent)

;;;;;;;;;;;;;;;
;; CONSTANTS ;;
;;;;;;;;;;;;;;;
; Directions Santa can move in
(define UP #\^)
(define DOWN #\v)
(define LEFT #\<)
(define RIGHT #\>)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; POSN RELATED FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (posn=? a b)
  (and (= (posn-x a) (posn-x b))
       (= (posn-y a) (posn-y b))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SANTA RELATED FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Consumes Santa and produces Santa after following all directions
(define (visit-houses s)
  (cond [(done? s) s]
        [else (let* ([dir (first (santa-directions s))]
                     [remn (rest (santa-directions s))]
                     [nxt-posn (move dir (santa-cur-posn s))]
                     [nxt-robo (move-robo dir (santa-robo-posn s))]
                     [visited (santa-visited-posns s)]
                     [updated (check-posns visited nxt-posn nxt-robo)])
                (visit-houses (santa remn updated nxt-posn nxt-robo)))]))

; Checks if Santa has completed his run
(define (done? s)
  (empty? (santa-directions s)))

; Consumes Santa's current position and direction and produces his position after moving
(define (move direction cur)
  (define x (posn-x cur))
  (define y (posn-y cur))
  (cond [(eq? direction UP) (posn x (add1 y))]
        [(eq? direction DOWN) (posn x (sub1 y))]
        [(eq? direction LEFT) (posn (sub1 x) y)]
        [(eq? direction RIGHT) (posn (add1 x) y)]))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start)
  (define directions (string->list (file->string "input.txt")))
  (define s (santa directions (list (posn 0 0)) (posn 0 0) (posn 0 0)))
  (length (santa-visited-posns (visit-houses s))))

;;;;;;;;;;;
;; Tests ;;
;;;;;;;;;;;
(define-test-suite all
  (test-case "posn functions"
             (check-true  (posn=? (posn 3 5) (posn 3 5)))
             (check-false (posn=? (posn 3 5) (posn 5 3))))
  (test-case "done?"
             (check-true (done? (santa (list) (list) (posn 0 0))))
             (check-false (done? (santa (list #\^) (list) (posn 0 0)))))
  (test-case "move"
             (check posn=? (move UP (posn 0 0)) (posn 0 1))
             (check posn=? (move DOWN (posn 0 0)) (posn 0 -1))
             (check posn=? (move LEFT (posn 0 0)) (posn -1 0))
             (check posn=? (move RIGHT (posn 0 0)) (posn 1 0))))