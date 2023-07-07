(defpackage :sieve
  (:use :cl)
  (:export :primes-to)
  (:documentation "Generates a list of primes up to a given limit."))

(in-package :sieve)

(defun index-of (number)
  (- number 2))

(defun is-composite (base list-of-is-prime)
 (not (nth (index-of base) list-of-is-prime)))

(defun primes-to (n)
  "List primes up to `n' using sieve of Eratosthenes."
  (let ((output-list '()))
    (progn
      ; Initialize the list of candidate numbers - initially, guessing they are all prime
      (let ((list-of-is-prime (loop for x from 2 to n collect T)))
        (loop for base from 2 to n do
          (unless (is-composite base list-of-is-prime)
            ; Initially I used `if (...) next-iteration (progn ...)` here, but although that
            ; worked for local test execution, in Exercism itself the tests errored with "The variable next-iteration
            ; is unbound"
            ;
            ; From here on, `base` is known to be prime
            (progn 
              ; Append `base` (a prime number) to `output-list` (of primes)...
              (setq output-list (append output-list (list base)))
              ; ...then loop over its multiples and mark them as composite
              (loop for multiplicand from 2 to n ; Technically, `to (/ n base)` - but the instructions explicitly say not to use division.
                    for multiplied-value = (* multiplicand base)
                    while (<= multiplied-value n)
                    ; mark `multiplied-value` as composite
                    do (setf (nth (index-of multiplied-value) list-of-is-prime) NIL))))))
      ; Finally, having added all the primes to `output-list`, return it.
      output-list)))
