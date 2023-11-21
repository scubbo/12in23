(defpackage :reporting-for-duty
  (:use :cl)
  (:export :format-quarter-value :format-two-quarters
           :format-two-quarters-for-reading))

(in-package :reporting-for-duty)

;; Define format-quarter-value function.
(defun format-quarter-value (name value)
  (format nil "The value ~A quarter: ~A" name value))

;; Define format-two-quarters function.
(defun format-two-quarters (stream name-1 value-1 name-2 value-2)
  (format stream "~%The value ~A quarter: ~A~%The value ~A quarter: ~A~%" name-1 value-1 name-2 value-2))

;; Define format-two-quarters-for-reading function.
(defun format-two-quarters-for-reading (stream name-1 value-1 name-2 value-2)
  (format stream "(~S ~S)" (format-quarter-value name-1 value-1) (format-quarter-value name-2 value-2)))
