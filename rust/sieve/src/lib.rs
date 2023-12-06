pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    if upper_bound < 2 {
        return vec![];
    }

    let length = upper_bound - 1;
    // `candidates` is a vec of bools whose ith value indicates that `i+2` is marked
    let mut candidates = vec![false;length.try_into().unwrap()];

    let mut output = Vec::new();
    for i in 0..length {
        println!("Checking {}", (i+2));
        if !candidates[usize::try_from(i).unwrap()] {
            println!("It is currently unmarked!");
            process(&mut candidates, i+2, length);
            output.push(i+2);
        }
    }
    return output;
}

fn process(candidates: &mut Vec<bool>, prime: u64, length: u64) {
    let mut count = 2;
    loop {
        let index = (count * prime) - 2;
        if index < length {
            println!("Marking {} as not-prime", (index + 2));
            candidates[usize::try_from(index).unwrap()] = true    
        } else {
            break
        }
        count += 1
    }
}
