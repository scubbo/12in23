(defpackage :raindrops
  (:use :cl)
  (:export :convert))

(in-package :raindrops)

(defun stringify (n) 
  (concatenate 'string
    (if (zerop (mod n 3)) "Pling" "")
    (if (zerop (mod n 5)) "Plang" "")
    (if (zerop (mod n 7)) "Plong" "")))

(defun convert (n)
  "Converts a number to a string of raindrop sounds."
  (let ((stringed (stringify n)))
    (if (equal "" stringed)
      (write-to-string n)
      stringed)))
