(defpackage :collatz-conjecture
  (:use :cl)
  (:export :collatz))

(in-package :collatz-conjecture)

(defun collatz (n)
  (if (< n 1)
    NIL

    (if (= n 1)
      0
      (if (zerop (mod n 2))
        (+ 1 (collatz (/ n 2)))
        (+ 1 (collatz (+ 1 (* 3 n))))
      )
    )
  )
)
