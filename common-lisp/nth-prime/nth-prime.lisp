(defpackage :nth-prime
  (:use :cl)
  (:export :find-prime))

(in-package :nth-prime)

(defun is-coprime-to (number factors)
  (notany
    (lambda (x) (zerop (mod number x)))
    factors))

(defun find-lowest-number-coprime-to (factors)
  (+ 1 (first (last (loop for x from (first (last factors)) until (is-coprime-to x factors) collect x)))))

(defun get-primes-up-to (idx)
  (cond
    ((= idx 1) '(2))
    (t (let ((lower-primes-up-to (get-primes-up-to (- idx 1))))
      (append lower-primes-up-to (list (find-lowest-number-coprime-to lower-primes-up-to)))))))

(defun find-prime (prime-index)
  (cond
    ((<= prime-index 0) NIL)
    (t (first (last (get-primes-up-to prime-index))))))
