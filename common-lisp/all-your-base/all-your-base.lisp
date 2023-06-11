(defpackage :all-your-base
  (:use :cl)
  (:export :rebase))

(in-package :all-your-base)

(defun to-dec-accum (list-digits in-base accum)
  (when (and (>= (car list-digits) 0) (< (car list-digits) in-base))
    (if
      (= 1 (length list-digits))
      (+ (car list-digits) accum)
      (to-dec-accum (cdr list-digits) in-base (* in-base (+ accum (car list-digits)))))))      

(defun to-dec (list-digits in-base)
  (to-dec-accum list-digits in-base 0))

(defun from-dec (num out-base)
  (if (< num out-base)
    (list num)
    (append (from-dec (floor (/ num out-base)) out-base) (list (mod num out-base)))))

(defun rebase (list-digits in-base out-base)
  ; This should actually be `(>= ... 1)`, the tests are wrong:
  ; base 1 is legitimate (it's just a number of `1`s equal to the value!)
  (when (and (>= in-base 2) (>= out-base 2))
    (if (not list-digits)
      (list 0) ; I'd say it should be nil, but, OK
      ; See comment in `to-dec-accum` - really this should be a try-catch.
      (when (to-dec list-digits in-base)
        (from-dec (to-dec list-digits in-base) out-base)))))
