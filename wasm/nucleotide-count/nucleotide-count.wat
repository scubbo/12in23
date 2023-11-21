;; Ongoing attempt

(module
  (memory (export "mem") 1)

  (func $charEquals (param $offset i32) (param $charCode i32) (result i32)
    (i32.eq (i32.load8_u (local.get $offset)) (local.get $charCode))
  )

  ;;
  ;; Count the number of each nucleotide in a DNA string.
  ;;
  ;; @param {i32} offset - The offset of the DNA string in memory.
  ;; @param {i32} length - The length of the DNA string.
  ;;
  ;; @returns {(i32,i32,i32,i32)} - The number of adenine, cytosine, guanine, 
  ;;                                and thymine nucleotides in the DNA string
  ;;                                or (-1, -1, -1, -1) if the DNA string is
  ;;                                invalid.
  ;;
  (func (export "countNucleotides") (param $offset i32) (param $length i32) (result i32 i32 i32 i32)
    (local $as i32)
    (local $cs i32)
    (local $gs i32)
    (local $ts i32)
    (local $pointerLoc i32)
    (local $i i32)

    (if (i32.eq (local.get $length) (i32.const 0))
      (then
        (return
          (i32.const 0)
          (i32.const 0)
          (i32.const 0)
          (i32.const 0)
        )
      )
    )

    (loop $for
      (local.set $pointerLoc (i32.add (local.get $i) (local.get $offset)))

      (if
        (call $charEquals (local.get $pointerLoc) (i32.const 65)) (then
        (local.set $as (i32.add (local.get $as) (i32.const 1)))
      ) (else (if
        (call $charEquals (local.get $pointerLoc) (i32.const 67)) (then
        (local.set $cs (i32.add (local.get $cs) (i32.const 1)))
      ) (else (if
        (call $charEquals (local.get $pointerLoc) (i32.const 71)) (then
        (local.set $gs (i32.add (local.get $gs) (i32.const 1)))
      ) (else (if
        (call $charEquals (local.get $pointerLoc) (i32.const 84)) (then
        (local.set $ts (i32.add (local.get $ts) (i32.const 1)))
      ) (else
        (return
          (i32.const -1)
          (i32.const -1)
          (i32.const -1)
          (i32.const -1)
        )
      ))))))))

      ;; For-loop logic: increment i...
      local.get $i
      i32.const 1
      i32.add
      local.set $i

      ;; ...and continue loop only if $i<$length
      local.get $i
      local.get $length
      i32.lt_s
      br_if $for
    )

    (return 
      (local.get $as)
      (local.get $cs)
      (local.get $gs)
      (local.get $ts)
    )
  )
)
