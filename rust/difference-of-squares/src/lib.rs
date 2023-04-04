use std::ops::Range;

pub fn square_of_sum(n: u32) -> u32 {
    sum_of(1..n+1).pow(2)
}

pub fn sum_of_squares(n: u32) -> u32 {
    // The below gives
    // `a value of type `std::ops::Range<u32>` cannot be built from an iterator over elements of type `u32``
    // Why?
    sum_of((0..n).map(|n| n.pow(2)))
    // (1..n+1).map(|n| n.pow(2)).reduce(|acc, e| acc+e).unwrap_or_else(|| 0)
}

fn sum_of(ns: Range<u32>) -> u32 {
    ns.reduce(|acc, e| acc + e).unwrap_or_else(|| 0)
}

pub fn difference(n: u32) -> u32 {
    square_of_sum(n) - sum_of_squares(n)
}
