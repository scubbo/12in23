pub fn actions(n: u8) -> Vec<&'static str> {
    let mut output = Vec::new();
    let number_as_binary = format!("{:b}", n);
    let length_of_string = number_as_binary.len();
    println!("{}", number_as_binary);
    for i in 0..4 {
        if length_of_string >= (i+1) {
            let char = &number_as_binary.as_bytes()[length_of_string - (i + 1)];
            if char == &"1".as_bytes()[0] {
                output.push(match i {
                    0 => "wink",
                    1 => "double blink",
                    2 => "close your eyes",
                    3 => "jump",
                    _ => panic!("Unmatched index")
                })
            }
        }
    }
    if length_of_string >= 5 && &number_as_binary.as_bytes()[length_of_string - 5] == &"1".as_bytes()[0] {
        output.reverse()
    }
    return output;
}
