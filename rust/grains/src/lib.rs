pub fn square(s: u32) -> u64 {
    match s {
        num if num > 0 && num < 65 => 2_u64.pow(num-1),
        _ => panic!("Square must be between 1 and 64")
    }
}

pub fn total() -> u64 {
    // Actually a more efficient way to do this would be `square(65)-1`,
    // but that's a mathematical solution rather than a programming one!
    // (Plus, it's prevented by the panic)
    //
    // 65 because Rust ranges are half-open.
    (1..65).map(square).sum()
}
