(defpackage :pascals-triangle
  (:use :cl)
  (:export :rows :row :wrap-in-ones))
(in-package :pascals-triangle)

(defun wrap-in-ones (inp)
  (cons 1
    ; append on an atom will "dot" it - need to "lift" it to a list to get
    ; the expected behaviour
    (append inp (list 1))))

(defun row (inp)
  (wrap-in-ones
    ; We know `inp` will have length at least 3 due to conditions
    ; in `rows`
    (loop for idx from 0 below (- (length inp) 1)
      collect (+ (nth idx inp) (nth (+ idx 1) inp)))))
  
  

(defun rows (n)
  (cond
    ((< n 1) NIL)
    ((= n 1) '((1)))
    ((= n 2) '((1) (1 1)))
    (t
      (let ((rows_so_far (rows (- n 1))))
        ; `first` because `last` returns a list whose element _is_ the last element
        (append rows_so_far (list (row (first(last rows_so_far)))))))))
