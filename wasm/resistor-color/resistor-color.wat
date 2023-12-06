(module
  (memory (export "mem") 1)

  (data (i32.const 100) "black,brown,red,orange,yellow,green,blue,violet,grey,white")

  ;;
  ;; Return buffer of comma separated colors
  ;; "black,brown,red,orange,yellow,green,blue,violet,grey,white"
  ;;
  ;; @returns {(i32, i32)} - The offset and length of the buffer of comma separated colors
  ;;
  (func (export "colors") (result i32 i32)
    (return (i32.const 100) (i32.const 58))
  )

  ;;
  ;; Initialization function called each time a module is initialized
  ;; Can be used to populate globals similar to a constructor
  ;; Can be deleted if not needed
  ;;
  (func $initialize)
  (start $initialize)

  ;;
  ;; Given a valid resistor color, returns the associated value
  ;;
  ;; @param {i32} offset - offset into the color buffer
  ;; @param {i32} len - length of the color string
  ;;
  ;; @returns {i32} - the associated value
  ;;
  (func (export "colorCode") (param $offset i32) (param $len i32) (result i32)
    (if
      (i32.eq (i32.load8_u (local.get $offset)) (i32.const 98)) ;; 'b'
      (then
        (if
          (i32.eq (i32.load8_u (i32.add (local.get $offset) (i32.const 1))) (i32.const 114)) ;; 'r'
          (then
            ;; br => brown
            (return (i32.const 1))
          )
          (else
            (if (i32.eq (i32.load8_u (i32.add (local.get $offset) (i32.const 2))) (i32.const 97)) ;; 'a'
              (then
                ;; b_a => black
                (return (i32.const 0))
              )
              (else
                ;; b<not-r><not-a> => blue
                (return (i32.const 6))
              )
            )
          )
        )
      )
    )

    (if
      (i32.eq (i32.load8_u (local.get $offset)) (i32.const 103)) ;; 'g'
      (then
        (if
          (i32.eq (i32.load8_u (i32.add (local.get $offset) (i32.const 3))) (i32.const 101)) ;; 'e'
          (then
            (return (i32.const 5))
          )
          (else
            (return (i32.const 8))
          )
        )
      
      
       (return (i32.const 5))))

    (if (i32.eq (i32.load8_u (local.get $offset)) (i32.const 114)) ;; 'r'
      (then (return (i32.const 2))))
    (if (i32.eq (i32.load8_u (local.get $offset)) (i32.const 111)) ;; 'o'
      (then (return (i32.const 3))))
    (if (i32.eq (i32.load8_u (local.get $offset)) (i32.const 121)) ;; 'y'
      (then (return (i32.const 4))))
    (if (i32.eq (i32.load8_u (local.get $offset)) (i32.const 118)) ;; 'v'
      (then (return (i32.const 7))))
    (if (i32.eq (i32.load8_u (local.get $offset)) (i32.const 119)) ;; 'w'
      (then (return (i32.const 9))))
    (return (i32.const -1))
  )
)
