(module
  (memory (export "mem") 1)

  (func $isLowercaseLetter (param $offset i32) (result i32)
    (i32.and
      (i32.ge_u (i32.load8_u (local.get $offset)) (i32.const 97))
      (i32.le_u (i32.load8_u (local.get $offset)) (i32.const 122))
    )
  )

  (func $isUppercaseLetter (param $offset i32) (result i32)
    (i32.and
      (i32.ge_u (i32.load8_u (local.get $offset)) (i32.const 65))
      (i32.le_u (i32.load8_u (local.get $offset)) (i32.const 90))
    )
  )

  (func $shiftWrapped (param $offset i32) (param $shiftKey i32) (param $max i32)
    (i32.store8 
      (local.get $offset)
      (i32.add (i32.load8_u (local.get $offset)) (local.get $shiftKey)))
    (if 
      (i32.gt_u (i32.load8_u (local.get $offset)) (local.get $max))
      (i32.store8 
        (local.get $offset)
        (i32.sub (i32.load8_u (local.get $offset)) (i32.const 26))))
  )

  (func (export "rotate") (param $textOffset i32) (param $textLength i32) (param $shiftKey i32) (result i32 i32)
    (local $offset i32)
    (local $length i32)
    (local $shifted i32)
    (local.set $offset (local.get $textOffset))
    (local.set $length (local.get $textLength))
    (local.set $shiftKey (i32.rem_u (local.get $shiftKey) (i32.const 26)))
    (loop $loop
      (if 
        (call $isLowercaseLetter (local.get $textOffset))
        (call $shiftWrapped (local.get $textOffset) (local.get $shiftKey) (i32.const 122)))
      (if 
        (call $isUppercaseLetter (local.get $textOffset))
        (call $shiftWrapped (local.get $textOffset) (local.get $shiftKey) (i32.const 90)))
      (local.set $textOffset (i32.add (local.get $textOffset) (i32.const 1)))
      (local.set $textLength (i32.sub (local.get $textLength) (i32.const 1)))
      (br_if $loop (local.get $textLength))
    )
    (return (local.get $offset) (local.get $length))
  )
)
;; Below is my original attempt, which attempted to avoid the repeated calls to `(i32.load8_u $loc)` in `rotateChar`,
;; but which gave an error
;; `Specifying memory variable is not allowed`
;; on the line `(local.set $charCode (i32.load8_u $loc))`
;;
;; Hoping a mentor can help me understand that a little better!
;;
;;   (func (export "rotateWithBaseOffset") (param $charCode i32) (param $base i32) (param $shiftKey i32) (result i32)
;;     (return
;;       (i32.add
;;         (i32.rem_s
;;           (i32.add
;;             (i32.sub (local.get $charCode) (local.get $base))
;;             (local.get $shiftKey)
;;           )
;;           (i32.const 26)
;;         )
;;         (local.get $base)
;;       )
;;     )
;;   )

;;   (func (export "rotateChar") (param $loc i32) (param $shiftKey i32) (result i32)
;;     (local $charCode i32)

;;     (local.set $charCode (i32.load8_u $loc))

;;     ;; Capital letters
;;     (if
;;       (i32.and
;;         (i32.ge_s (local.get $charCode) (i32.const 65))
;;         (i32.le_s (local.get $charCode) (i32.const 90))
;;       )
;;       (then
;;         (return (call $rotateWithBaseOffset (local.get $charCode) (i32.const 65) (local.get $shiftKey)))
;;       )
;;     )

;;     ;; Lowercase letters
;;     (if
;;       (i32.and
;;         (i32.ge_s (local.get $charCode) (i32.const 97))
;;         (i32.le_s (local.get $charCode) (i32.const 122))
;;       )
;;       (then
;;         (return (call $rotateWithBaseOffset (local.get $charCode) (i32.const 97) (local.get $shiftKey)))
;;       )
;;     )

;;     ;; Non-letters
;;     (return (local.get $charCode))
;;   )

;;   ;;
;;   ;; Encrypt plaintext using the rotational cipher.
;;   ;;
;;   ;; @param {i32} textOffset - The offset of the plaintext input in linear memory.
;;   ;; @param {i32} textLength - The length of the plaintext input in linear memory.
;;   ;; @param {i32} shiftKey - The shift key to use for the rotational cipher.
;;   ;;
;;   ;; @returns {(i32,i32)} - The offset and length of the ciphertext output in linear memory.
;;   ;;
;;   (func (export "rotate") (param $textOffset i32) (param $textLength i32) (param $shiftKey i32) (result i32 i32)
;;     (local $loc i32)
;;     (local $endPos i32)
;;     (local.set $loc (local.get $textOffset))
;;     (local.set $endPos (i32.add (local.get $textOffset) (local.get $textLength)))

;;     (loop $for
;;       (i32.store
;;         (local.get $loc)
;;         (call $rotateChar (local.get $loc) (local.get $shiftKey)))

;;       (local.set (i32.add (local.get $loc) (i32.const 1)))
;;       (br_if $for (i32.lt_s
;;         (local.get $loc)
;;         (local.get $endPos)
;;       ))
;;     )

;;     (return (local.get $textOffset) (local.get $textLength))
;;   )
;; )
