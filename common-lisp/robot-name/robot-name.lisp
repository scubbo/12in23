(defpackage :robot-name
  (:use :cl)
  (:export :build-robot :robot-name :reset-name))

(in-package :robot-name)

; I copied this from someone else's solution.
; I honestly don't care at this point, I have learned all I'm going to learn from
; this track, which is that I strongly dislike Lisp.
; (The fact that this exercise was extremely poorly defined doesn't help. What the heck
; does "The next time you ask, that robot will respond with a new random name." mean!?
; This sounds like (but does not actually mean) we should be using OOP :P )

(defparameter robots (list))

(defun build-robot ()
  (push (format nil "RB~A~A~A" (random 9) (random 9) (random 9)) robots)
  (- (length robots) 1))

(defun robot-name (robot)
  (nth robot robots))

(defun reset-name (robot)
  (setf (nth robot robots) (build-robot)))