(defpackage :lucys-magnificent-mapper
  (:use :cl)
  (:export :make-magnificent-maybe :only-the-best))

(in-package :lucys-magnificent-mapper)


;; Define make-magnificent-maybe function
(defun make-magnificent-maybe (f nums)
  (mapcar f nums)
)


;; Define only-the-best function
(defun only-the-best (f nums)
  (remove-if f (remove 1 nums))
)