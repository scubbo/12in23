(defpackage :larrys-winning-checker
  (:use :cl)
  (:export
   :make-empty-board
   :make-board-from-list
   :all-the-same-p
   :row
   :column))

(in-package :larrys-winning-checker)

(defun make-empty-board ()
  #2A((NIL NIL NIL) (NIL NIL NIL) (NIL NIL NIL)))

(defun make-board-from-list (list)
  (make-array (list (length list)
                    (length (first list)))
              :initial-contents list))

(defun all-the-same-p (row-or-col)
  (and
    (eq (aref row-or-col 0) (aref row-or-col 1))
    (eq (aref row-or-col 0) (aref row-or-col 2))))

(defun row (board row-num)
  ; God this is so bad. I miss Python's List Comprehensions.
  ; Still, at least it's better than `#A((aref board row-num 0) (aref board row-num 1) (aref board row-num 2))`...
  (make-array
    3
    :initial-contents (loop for x in '(0 1 2)
      collect (aref board row-num x))))
  

(defun column (board col-num)
  (make-array
    3
    :initial-contents (loop for x in '(0 1 2)
      collect (aref board x col-num))))
