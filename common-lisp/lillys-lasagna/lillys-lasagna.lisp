(defpackage :lillys-lasagna
  (:use :cl)
  (:export :expected-time-in-oven
           :remaining-minutes-in-oven
           :preparation-time-in-minutes
           :elapsed-time-in-minutes))

(in-package :lillys-lasagna)

;; Define function expected-time-in-oven
(defun expected-time-in-oven () "blah" 337)

;; Define function remaining-minutes-in-oven
(defun remaining-minutes-in-oven (so-far) "foo" (- (expected-time-in-oven) so-far))

;; Define function preparation-time-in-minutes
(defun preparation-time-in-minutes (layers) "baz" (* layers 19))

;; Define function elapsed-time-in-minutes
(defun elapsed-time-in-minutes (layers so-far) "qux" (+ (preparation-time-in-minutes layers) so-far))
