use unicode_segmentation::UnicodeSegmentation;

pub fn reverse(input: &str) -> String {
    input.graphemes(true).rev().collect()
}

// Gives error "the trait bound `StrSearcher<'_, '_>: DoubleEndedSearcher<'_>` is not satisfied"...
//
// "the trait `DoubleEndedSearcher<'_>` is not implemented for `StrSearcher<'_, '_>" (highlighting `input.split("")`)
//
// I can understand what this literally _means_ - a trait is required but not implemented - but I
// don't understand _why_ it's the case. `rev` seems to require that the thing it operates on
// is a `DoubleEndedIterator`, and being a `DoubleEndedIterator` requires the trait `DoubleEndedSearcher`,
// but then:
// * If `input.split("")` doesn't satisfy the traits that `rev` requires, then why was `rev` present in
//    IntelliJ's autocomplete as a method, and why wasn't there a red-underline on invalid syntax?
// * Why _doesn't_ `input.split("")` implement `DoubleEndedIterator`? I'm inferring that that trait means
//    "it's possible to iterate from the end of this string to the beginning" - why would that property
//    ever be false for the result of calling `.split("")` on a (implicitly finite) string?
//
// (I do acknowledge that this solution is flawed because of the existence of graphemes, but my
// question about "how the language works" still stands)
//
// pub fn reverse_first_attempt(input: &str) -> String {
//     String::from(input.split("").rev()
//         // I would have tried to `.collect().join()` here,
//         // but apparently `.collect()` doesn't exist on this type?
//         .fold(String::new(), |a, b| a + b)
//         .strip_prefix(" ").unwrap()
//         .strip_suffix(" ").unwrap())
// }