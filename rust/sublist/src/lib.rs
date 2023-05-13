#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

// Why is it necessary to `use compare::Compare`?
// It's not actually _used_ anywhere - but, without a use of it,
// Rust is unable to infer the type of `natural`
use compare::{Compare, natural};
use std::cmp::Ordering::{Less, Equal, Greater};

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    match natural().compare(&_first_list.len(), &_second_list.len()) {
        Less => if check_is_sublist_unequal_length(_first_list, _second_list) {Comparison::Sublist} else {Comparison::Unequal},
        Equal => if _first_list == _second_list {Comparison::Equal} else {Comparison::Unequal},
        Greater => if check_is_sublist_unequal_length(_second_list, _first_list) {Comparison::Superlist} else {Comparison::Unequal}
    }
}

fn check_is_sublist_unequal_length<T: PartialEq>(maybe_sub: &[T], maybe_super: &[T]) -> bool {
    let sub_len = maybe_sub.len();
    let sup_len = maybe_super.len();
    if sub_len == 0 {
        return true
    }
    for i in 0..sup_len {
        if maybe_super[i] == maybe_sub[0] {
            // Why does `maybe_super` need to be reborrowed here? It's _already_ borrowed in the method signature
            // (Without this borrow, I get "no implementation for `[T] == &[T]`")
            if (i+sub_len < sup_len+1) && (&maybe_super[i..i+sub_len] == maybe_sub) {
                return true
            }
            // An optimized approach here would jump ahead in the false case by as far
            // as was compared before finding an inequality.
        }
    }
    false
}