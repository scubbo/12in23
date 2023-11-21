(defpackage :binary-search
  (:use :cl)
  (:export :binary-find :value-error))

(in-package :binary-search)

(defun binary-find (arr el)
  (if
    (= 0 (length arr))
    nil
    (let ((middle-index (floor (/ (length arr) 2))))
      (cond
        ((= (aref arr middle-index) el) middle-index)
        ((> (aref arr middle-index) el) (binary-find (subseq arr 0 middle-index) el))
        ((< (aref arr middle-index) el) 
          (let ((popped-value (binary-find (subseq arr (+ middle-index 1)) el)))
            (if popped-value
              (+ middle-index (+ 1 popped-value))
              nil
            )
          )
        )))))
