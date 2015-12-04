#lang racket
(require file/md5)
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
  (define hash (get-hash (string-append key (number->string num))))
  (if (answer? hash)
      num
      (get-answer key (add1 num))))

;;;;;;;;;;
;; MAIN ;;
;;;;;;;;;;
(define (start key)
  (get-answer key 1))