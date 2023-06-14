(defpackage :perfect-numbers
  (:use :cl)
  (:export :classify))

(in-package :perfect-numbers)

(defun factors (n)
  (loop for x
    from 1
    until (>= x (- n 1))
    when (zerop (mod n x))
    collect x))

(defun aliquot (n)
  (reduce #'+ (factors n)))

(defun classify (n)
  (when (> n 0)
    (let ((ali (aliquot n)))
      (cond
        ((< ali n) "deficient")
        ((> ali n) "abundant")
        ((= ali n) "perfect")))))
  
