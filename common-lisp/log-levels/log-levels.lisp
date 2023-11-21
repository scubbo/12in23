(defpackage :log-levels
  (:use :cl)
  (:export :log-message :log-severity :log-format))

(in-package :log-levels)

(defun log-message (log-string)
  (subseq log-string 8))

(defun log-severity (log-string)
  (cond
    ((string= "info" (string-downcase (subseq log-string 1 5))) :everything-ok)
    ((string= "warn" (string-downcase (subseq log-string 1 5))) :getting-worried)
    ((string= "ohno" (string-downcase (subseq log-string 1 5))) :run-for-cover)))
; Weird string-comparison logic means we cannot do the more sensible:
;  (case (string-downcase (subseq log-string 1 5))
;    ("info" :everything-ok)
;    ("warn" :getting-worried)
;    ("ohno" :run-for-cover)))


(defun log-format (log-string)
  (case (log-severity log-string)
    (:everything-ok (string-downcase (log-message log-string)))
    (:getting-worried (string-capitalize (log-message log-string)))
    (:run-for-cover (string-upcase (log-message log-string)))))
