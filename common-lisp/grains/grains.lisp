(defpackage :grains
  (:use :cl)
  (:export :square :total))
(in-package :grains)

(defun square (n)
  (expt 2 (- n 1)))

(defun total ()
  ; There's a mathematical shortcut that is more efficient than the below -
  ; but I'm trying to learn Lisp, not maths!
  (apply #'+
    (loop for n from 1 below 65
      collect (square n))))
