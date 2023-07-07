(defpackage :lillys-lasagna-leftovers
  (:use :cl)
  (:export
   :preparation-time
   :remaining-minutes-in-oven
   :split-leftovers))

(in-package :lillys-lasagna-leftovers)

;; Define function preparation-time
(defun preparation-time (&rest r)
  (* (length r) 19))

;; Define function remaining-minutes-in-oven
(defun remaining-minutes-in-oven (&optional (mod 'absent))
  (+ 337 
    (cond 
      ((eql mod nil) -337)
      ((eql mod 'absent) 0)
      ((eql mod :normal) 0)
      ((eql mod :shorter) -100)
      ((eql mod :longer) 100)
      ((eql mod :very-short) -200)
      ((eql mod :very-long) 200))))
  

;; Define function split-leftovers
(defun split-leftovers (&key (human 10) (alien 10) (weight 'absent))
  (cond
    ((eql weight 'absent) :just-split-it)
    ((eql weight nil) :looks-like-someone-was-hungry)
    (t (- weight (+ human alien)))))
  
