(defpackage :difference-of-squares
  (:use :cl)
  (:export :sum-of-squares
           :square-of-sum
           :difference
           :list-a-to-n))

(in-package :difference-of-squares)

(defun list-a-to-n (a n)
  (if (= a n)
    (list n)
    (cons a (list-a-to-n (+ a 1) n))))

(defun square-of-sum (n)
  ; LOL, don't use `defvar` or you're going to have a bad time! :)
  (let ((s (reduce #'+ (list-a-to-n 1 n))))
    (* s s)))
  

(defun sum-of-squares (n)
  "Calculates the sum of squares for a given number."
  (if (= n 1)
    1
    (+ (* n n) (sum-of-squares (- n 1)))))

(defun difference (n)
  "Finds the diff. between the square of the sum and the sum of the squares."
  (- (square-of-sum n) (sum-of-squares n)))
