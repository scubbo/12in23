// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

use std::collections::HashMap;

pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {
    let magazine_count = word_count(magazine);
    let note_count = word_count(note);
    for note_key in note_count.keys() {
        if *magazine_count.get(note_key).unwrap_or(&0) < note_count[note_key] {
            return false
        }
    }
    return true
}

// Why are these "named lifetime parameters" necessary? I added them because
// of the error message that arose without them, and I then read through
// https://doc.rust-lang.org/book/ch10-03-lifetime-syntax.html to understand
// what named lifetime parameters _are_ and what value they serve - but I don't
// see why they're relevant in this case? By calling `map.entry(*s)` (and
// dereferencing `s`, doesn't the key of the map become independent of the input strings?
fn word_count<'a>(strings: &'a[&'a str]) -> HashMap<&str, u32> {
    let mut map = HashMap::new();
    for s in strings {
        *map.entry(*s).or_insert(0) += 1;
    }
    return map
}

// This was an earlier attempt that I made before reading `NOTES.md
//
// fn word_count<'a>(strings: &'a[&'a str]) -> HashMap<&str, u32> {
//     let mut map = HashMap::new();
//     for s in strings {
//         match map.get_mut(s) {
//             Some(v) => *v = *v+1,
//             None => {
//                 map.insert(*s, 1);
//                 // This is a really awkward way to force the branch ("arm"?)
//                 // into having a non-Option return type. Is there a better way?
//                 ()
//             }
//         }
//     }
//     return map
// }
