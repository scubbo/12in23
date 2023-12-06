use std::collections::HashSet;

/// Determine whether a sentence is a pangram.
pub fn is_pangram(sentence: &str) -> bool {
    let mut presence: HashSet<char> = HashSet::new();
    sentence.chars().into_iter().for_each(|c| {
        if c.is_alphabetic() && c.is_ascii() {
            presence.insert(c.to_ascii_lowercase());
        }
    });
    return presence.len() == 26;
}
