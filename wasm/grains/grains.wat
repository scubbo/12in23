(module
  ;;
  ;; Calculate the number of grains of wheat on the nth square of the chessboard
  ;;
  ;; @param {i32} squareNum - The square of the chessboard to calculate the number of grains for
  ;;
  ;; @returns {i64} - The number of grains of wheat on the nth square of the 
  ;;                  chessboard or 0 if the squareNum is invalid. The result
  ;;                  is unsigned.
  ;;
  (func $square (export "square") (param $squareNum i32) (result i64)
    (if
      (i32.or
        (i32.lt_s (local.get $squareNum) (i32.const 1))
        (i32.gt_s (local.get $squareNum) (i32.const 64))
      )
      (then
        (return (i64.const 0))
      )
    )
    i64.const 1
    (i64.extend_i32_s (i32.sub (local.get $squareNum) (i32.const 1)))
    i64.shl
  )

  ;;
  ;; Calculate the sum of grains of wheat acrosss all squares of the chessboard
  ;;
  ;; @returns {i64} - The number of grains of wheat on the entire chessboard.
  ;;                  The result is unsigned.
  ;;
  (func (export "total") (result i64)
    (i64.sub
      (i64.mul
        (call $square (i32.const 64))
        (i64.const 2)
      )
      (i64.const 1)
    )
  )
)
