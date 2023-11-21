(defpackage :two-fer
  (:use :cl)
  (:export :twofer))
(in-package :two-fer)

(defun twofer (&optional (name "you"))
  (format nil "One for ~A, one for me." (if name name "you")))
  
