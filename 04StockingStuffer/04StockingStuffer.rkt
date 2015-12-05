#lang racket
(require openssl/md5 rackunit rackunit/text-ui)
#|
Santa needs help mining some AdventCoins (very similar to bitcoins) to use
as gifts for all the economically forward-thinking little girls and boys.

To do this, he needs to find MD5 hashes which, in hexadecimal, start with
at least five zeroes. The input to the MD5 hash is some secret key (your
puzzle input, given below) followed by a number in decimal. To mine
AdventCoins, you must find Santa the lowest positive number
(no leading zeroes: 1, 2, 3, ...) that produces such a hash.

Your puzzle input is yzbqklnj.
|#

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
; Consumes the key and current number to try and produces the answer
(define (get-answer key num)
  (define to-hash (open-input-string (string-append key (number->string num))))
  (define hash (md5 to-hash))
  (if (answer? hash)
      num
      (get-answer key (add1 num))))

; Returns true if hash starts with five zeroes
(define (answer? hash)
  (define first-group (substring hash 0 NUM-TO-FIND))
  (string=? first-group MATCH))

; Repeats a string a number of times
(define (string-repeat n str)
  (string-append* (make-list n str)))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
; Number of leading digits to match
(define NUM-TO-FIND 5)
; Pattern of leading digits to match
(define MATCH (string-repeat NUM-TO-FIND "0"))

(define (start key)
  (get-answer key 1))


;;;;;;;;;;;
;; TESTS ;;
;;;;;;;;;;;
(define-test-suite all
  (test-case "answer?"
             (check-true (answer? MATCH))
             (check-false (answer? (string-append "n" MATCH))))
  ; These tests assume that NUM-TO-FIND is set to 5
  (test-case "get-answer"
             (check-eq? (get-answer "abcdef" 609043) 609043)
             (check-eq? (get-answer "pqrstuv" 1048970) 1048970)))