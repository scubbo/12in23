(defpackage :triangle
  (:use :cl)
  (:export :triangle-type-p))

(in-package :triangle)

(defun triangle-type-p (type a b c)
  (if
    (or 
      (eq a 0)
      (eq b 0)
      (eq c 0)
      (<= (+ a b) c)
      (<= (+ a c) b)
      (<= (+ b c) a))
    NIL
    ; else - it's a valid triangle, so continue
    (case type
      (:equilateral (and (eq a b) (eq a c)))
      (:isosceles (or
        (eq a b)
        (eq a c)
        (eq b c)))
      (:scalene (not (or (eq a b) (eq a c) (eq b c)))))))
