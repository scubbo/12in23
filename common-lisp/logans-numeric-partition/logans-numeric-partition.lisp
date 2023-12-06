(defpackage :logans-numeric-partition
  (:use :cl)
  (:export :categorize-number :partition-numbers))

(in-package :logans-numeric-partition)

;; Define categorize-number function
(defun categorize-number (lists num)
  (if
    (oddp num)
    (cons
      (cons num (car lists))
      (cdr lists))
    (cons
        (car lists)
        (cons num (cdr lists)))
  )
)

;; Define partition-numbers function
(defun partition-numbers (nums)
  (reduce #'categorize-number nums :initial-value '(() . ())))
