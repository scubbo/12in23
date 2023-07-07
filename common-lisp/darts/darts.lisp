(defpackage :darts
  (:use :cl)
  (:export :score))

(in-package :darts)

(defun score (x y)
  (let ((rad (sqrt (+ (* x x) (* y y)))))
    (cond
      ((> rad 10) 0)
      ((> rad 5) 1)
      ((> rad 1) 5)
      (t 10))))
