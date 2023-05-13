pub fn is_leap_year(year: u64) -> bool {
    is_divisible(&year, 4) && ((!is_divisible(&year, 100)) || is_divisible(&year, 400))
}

fn is_divisible(n: &u64, d: u64) -> bool {
    (*&n % d) == 0
}
