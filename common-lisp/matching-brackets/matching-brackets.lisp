
(defpackage :matching-brackets
  (:use :cl)
  (:export :pairedp))

(in-package :matching-brackets)

(defun does-bracket-match (a b)
    (cond 
        ((and (string= a "(") (string= b ")")) t)
        ((and (string= a "[") (string= b "]")) t)
        ((and (string= a "{") (string= b "}")) t)
        (t nil)
    )
)

(defun iterate-vals (vals stack)
    (let* (
        (current (first vals))
        (top (car stack))
        )

    (cond 
        ((member current '("(" "[" "{") :test #'string=) (iterate-vals (rest vals) (cons current stack)))
        ((and (member current '(")" "]" "}") :test #'string=) (does-bracket-match top current)) (iterate-vals (rest vals) (cdr stack)))
        ((and (member current '(")" "]" "}") :test #'string=) (not (does-bracket-match top current))) nil)
        ((and (eq current nil) (eq top nil)) t)
        ((not (eq current nil)) (iterate-vals (rest vals) stack))
        (t nil)
    )
)
)

(defun pairedp (value)
    (let (
            (elts (mapcar 'string (coerce value 'list)))
            (stack nil)
        )
    (iterate-vals elts stack)
    )
)