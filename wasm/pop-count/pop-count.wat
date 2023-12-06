(module
  (export "eggCount" (func $eggCount))
  ;;
  ;; count the number of 1 bits in the binary representation of a number
  ;;
  ;; @param {i32} number - the number to count the bits of
  ;;
  ;; @returns {i32} the number of 1 bits in the binary representation of the number
  ;;
  (func $eggCount (param $number i32) (result i32)
    (if
      (i32.eq (local.get $number) (i32.const 0))
      (then
        (return (i32.const 0))
      )
    )
    (if
      (i32.eq (local.get $number) (i32.const 1))
      (then
        (return (i32.const 1))
      )
    )

    ;; $number > 1
    (if
      (i32.eq (i32.rem_s (local.get $number) (i32.const 2)) (i32.const 1))
      (then
        (return (i32.add (i32.const 1) (call $eggCount (i32.div_s (local.get $number) (i32.const 2)))))
      )
      (else ;; $number is divisible by 2
        (return (i32.const 1) (call $eggCount (i32.div_s (local.get $number) (i32.const 2))))
      )
    )
    (return (i32.const -1))
  )
)
