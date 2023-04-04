use std::collections::{HashMap, HashSet};

// First attempt, which gives a lot of errors, starting with:
//
// `the method `entry` exists for struct `HashMap<HashMap<char, i32>, HashSet<&str>>`, but its trait bounds were not satisfied`
// ...
// the following trait bounds were not satisfied:
// `HashMap<char, i32>: Hash`
//
// which I assume means that a HashMap isn't a suitable key for a HashMap because it's not, itself, hashable.
// pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&str]) -> HashSet<&'a str> {
//     let mut char_counts: HashMap<HashMap<char, i32>, HashSet<&str>> = HashMap::new();
//     for candidate in possible_anagrams {
//         if candidate == word {
//             continue;
//         }
//         char_counts.entry(hashify(candidate).or_insert(HashSet::new())).push(candidate)
//     }
//     (*char_counts.get(&hashify(word))).or_else(HashSet::new()).unwrap()
// }
//
// fn hashify(candidate: &str) -> HashMap<char, i32> {
//     let mut out_map: HashMap<char, i32> = HashMap::new();
//     for mut char in candidate.chars() {
//         char.make_ascii_lowercase()
//         *(out_map.entry(char).or_insert(0)) += 1
//     }
//     out_map
// }

// Below doesn't work because Vec's encode order
// pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
//     let mut char_counts: HashMap<Vec<(char, i32)>, HashSet<&str>> = HashMap::new();
//     for candidate in possible_anagrams {
//         if *candidate == word {
//             continue;
//         }
//         (*char_counts.entry(hashify(candidate)).or_insert(HashSet::new())).insert(candidate);
//     }
//     // Cannot do simply:
//     //
//     // *char_counts.get(&hashify(word)).unwrap_or(&HashSet::new())
//     //
//     // because `cannot move out of a shared reference`
//     (*char_counts.get(&hashify(word)).unwrap_or(&HashSet::new())).clone()
// }
//
// fn hashify(candidate: &str) -> Vec<(char, i32)> {
//     let mut char_count_map: HashMap<char, i32> = HashMap::new();
//     for mut char in candidate.chars() {
//         char.make_ascii_lowercase();
//         *char_count_map.entry(char).or_insert(0) += 1
//     }
//     let mut out_vec: Vec<(char, i32)> = Vec::new();
//     for (c, count) in char_count_map {
//         out_vec.push((c, count))
//     }
//     println!("hashify for {}", candidate);
//     println!("{:?}", out_vec);
//     out_vec
// }

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let mut out_set = HashSet::new();

    let word_length = word.len();
    let word_letter_count = count_letters(word);
    for candidate in possible_anagrams {
        if candidate.len() != word_length {
            continue;
        }

        // This could be optimized, if desired, by passing in the expected
        // `word_letter_count` to a `-> bool` method which early-returns false
        // if the count is ever exceeded.
        if count_letters(candidate) == word_letter_count {
            if ! (*candidate.to_lowercase() == word.to_lowercase()) {
                out_set.insert(*candidate);
            }
        }
    }
    out_set
}

// Must be `<String, i32>` and not `<char, i32>` because, in general,
// the lowercase of a character might not be a single character.
// (Unicode, yo)
fn count_letters(word: &str) -> HashMap<String, i32> {
    let mut out_map = HashMap::new();
    for c in word.chars() {
        *out_map.entry(c.to_lowercase().to_string()).or_insert(0) += 1
    }
    out_map
}