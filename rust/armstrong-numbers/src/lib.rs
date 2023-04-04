pub fn is_armstrong_number(num: u32) -> bool {
    let num_as_vector = vectorize_number(num);
    let number_of_digits = num_as_vector.len();
    let raised_number = find_raised_number(num_as_vector, number_of_digits);
    raised_number == num as u64
}

fn vectorize_number(num: u32) -> Vec<u32> {
    if num == 0 {
        return vec![0]
    }
    // We don't actually care about the order of the digits, so can safely just push them on
    // even though that will result in a vector in opposite order
    let mut index = 0;
    let mut vec = Vec::new();
    // I don't know why there's a test about "wrapping arithmetic" which fails without this
    // (and various other "upcasts"), feels like an unnecessary complication.
    let larger_num = num as u64;
    while larger_num >= 10_u64.pow(index) {
        vec.push(find_ith_digit(&num, &index) as u32);
        index+=1;
    }
    vec
}

fn find_ith_digit(num: &u32, i: &u32) -> u64 {
    ((*num as u64) % (10_u64.pow(i+1))) / (10_u64.pow(*i))
}

fn find_raised_number(num_as_vector: Vec<u32>, number_of_digits: usize) -> u64 {
    num_as_vector.iter()
        .map(|x| *x as u64)
        .map(|x| x.pow(number_of_digits as u32))
        .reduce(|x, y| x.saturating_add(y)).unwrap()
}
