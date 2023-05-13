use std::cmp::{max, min, Ordering};
use std::collections::{HashMap, HashSet};
use std::iter::Map;
use crate::HandType::{Flush, FourOfAKind, FullHouse, HighCard, OnePair, Straight, StraightFlush, ThreeOfAKind, TwoPair};
use crate::Suit::{Club, Diamond, Heart, Spade};
use compare::{Compare, natural};

/// Given a list of poker hands, return a list of those hands which win.
///
/// Note the type signature: this function should return _the same_ reference to
/// the winning hand(s) as were passed in, not reconstructed strings which happen to be equal.
pub fn winning_hands<'a>(hands: &[&'a str]) -> Vec<&'a str> {
    let length = hands.len();
    // Why is a type annotation required here?
    let mut mapped_hands: Vec<HandType> = hands.iter().map(|s| HandType::new(s)).collect();
    // The below is copied from README.md
    mapped_hands.sort_by(|a, b| a.partial_cmp(b).unwrap_or(Ordering::Equal));
    // TODO: I need to plumb through the original string. Sigh.
    mapped_hands[length-1]
//     unimplemented!("Not defined")
}

impl HandType {
    fn new(cards_as_str: &str) -> HandType {
        // Why is a type annotation required here?
        let cards: Vec<Card> = cards_as_str.split(" ").map(|cs| Card::new(cs)).collect();
        if all_same_suit(&cards) {
            return match is_straight(&cards) {
                Some(high_card) => StraightFlush(high_card),
                None => Flush
            }
        }
        // There's some slight inefficiency here by checking for each of these in order,
        // when they could checked on a single traversal, but I don't think we're aiming
        // for blistering speed here.
        let val_counts = count_values(&cards);
        match is_four_of_a_kind(&val_counts) {
            Some(four_of) => return FourOfAKind(*four_of),
            _ => ()
        }
        match is_full_house(&val_counts) {
            Some((higher, lower)) => return FullHouse(*higher, *lower),
            _ => ()
        }
        // Flush already covered in `all_same_suit` above
        // Again, minor inefficiency in that we could have cached the `is_straight` response.
        match is_straight(&cards) {
            Some(high) => return Straight(high),
            _ => ()
        }
        match is_three_of_a_kind(&val_counts) {
            Some(three_of) => return ThreeOfAKind(*three_of),
            _ => ()
        }
        match is_two_pair(&val_counts) {
            Some((high, low)) => return TwoPair(*high, *low),
            _ => ()
        }
        match is_pair(&val_counts) {
            Some(two_of) => return OnePair(*two_of),
            _ => HighCard(cards.into_iter().map(|c| c.val).max().unwrap())
        }
    }
}

// helpful fns

fn all_same_suit(cards: &Vec<Card>) -> bool {
    let first_suit = &cards[0].suit;
    cards.iter().map(|c| &c.suit).all(|s| s == first_suit)
}

// Returns an Option - present if is a straight (and contains the high-value), else absent
fn is_straight(cards: &Vec<Card>) -> Option<i64> {
    let mut min = 14;
    let mut max = 0;
    let mut seen_so_far: HashSet<i64> = HashSet::new();
    for val in cards.iter().map(|c| c.val) {
        if val < min {
            min = val
        }
        if val > max {
            max = val
        }
        // Returns false if already present
        if !seen_so_far.insert(val) {
            return None;
        }
    }
    if max - min == 4 {
        Some(max)
    } else {
        None
    }
}

fn count_values(cards: &Vec<Card>) -> HashMap<i64, usize> {
    let mut out_map = HashMap::new();
    cards.iter().map(|c| c.val).for_each(|val| {
        *out_map.entry(val).or_insert(0) += 1
    });
    out_map
}

fn is_four_of_a_kind(counts: &HashMap<i64, usize>) -> Option<&i64> {
    is_n_of_a_kind(counts, 4)
}

fn is_three_of_a_kind(counts: &HashMap<i64, usize>) -> Option<&i64> {
    is_n_of_a_kind(counts, 3)
}

fn is_pair(counts: &HashMap<i64, usize>) -> Option<&i64> {
    is_n_of_a_kind(counts, 2)
}

fn is_full_house(counts: &HashMap<i64, usize>) -> Option<(&i64, &i64)> {
    // Cheating a little here by relying on the fact that the only
    // 2-integer sum to 5 is 2+3
    let two_plus_counts: Vec<(&i64, &usize)> = counts.iter().filter(|e| e.1 == &2 || e.1 == &3).collect();
    // Why is the slice required below? (Otherwise, I get
    // "pattern cannot match with input type `Vec<(&i64, &usize)>`" - but it can!
    match two_plus_counts[..] {
        [(x, &2), (y, &3)] => Some((y, x)),
        [(x, &3), (y, &2)] => Some((x, y)),
        _ => None
    }
}

fn is_two_pair(counts: &HashMap<i64, usize>) -> Option<(&i64, &i64)> {
    let two_counts: Vec<(&i64, &usize)> = counts.iter().filter(|e| e.1 == &2).collect();
    match two_counts[..] {
        [(x, &2), (y, &2)] => Some((max(x, y), min(x, y))),
        _ => None
    }
}

fn is_n_of_a_kind(counts: &HashMap<i64, usize>, n: usize) -> Option<&i64> {
    counts.iter().find(|e| e.1 == &n).map(|e| e.0)
}


// helpful structs

#[derive(Debug)]
struct Card {
    val: i64,
    suit: Suit
}

impl Card {
    fn new(card: &str) -> Card {
        let mut chars = card.chars();
        let first = chars.next().unwrap();
        let second = chars.next().unwrap();
        Card {
            val: match first {
                'J' => 11,
                'Q' => 12,
                'K' => 13,
                n => char::to_digit(n, 10).unwrap() as i64
            },
            suit: match second {
            'C' => Club,
            'H' => Heart,
            'S' => Spade,
            'D' => Diamond,
            s => panic!("Unexpected suit: ${s}")
        }}
    }
}


#[derive(Eq, PartialEq, Debug)]
enum HandType {
    StraightFlush(i64), // High value
    FourOfAKind(i64),
    FullHouse(i64, i64), // 3 then 2
    Flush,
    Straight(i64), // High value
    ThreeOfAKind(i64),
    TwoPair(i64, i64), // Highest then lowest
    OnePair(i64),
    HighCard(i64)
}

impl PartialOrd for HandType {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        // I searched around a bunch, but I can't find a way to retrieve
        // "the first field of an enum". Which makes a _sort_ of sense
        // since Enums can have different shapes (numbers and types of
        // fields) - except in this case it actually doesn't, because
        // everything except `Flush` _does_ have a first value, so
        // something like:
        //
        // match self {
        //   Flush => None
        //   _ => natural().cmp(self.0, other.0)
        // }
        //
        // could be reasonable attempted.
        match (self, other) {
            (StraightFlush(a), StraightFlush(b)) |
                (FourOfAKind(a), FourOfAKind(b)) |
                (FullHouse(a, _), FullHouse(b, _)) |
                (Straight(a), Straight(b)) |
                (ThreeOfAKind(a),ThreeOfAKind(b)) |
                (TwoPair(a, _), TwoPair(b, _)) |
                (OnePair(a), OnePair(b)) |
                (HighCard(a), HighCard(b)) => Some(natural().cmp(a, b)),
            (Flush, Flush) => None,
            _ => handTypeRoughValue(self).partial_cmp(&handTypeRoughValue(other))
        }
    }
}

fn handTypeRoughValue(ht: &HandType) -> i64 {
    match ht {
        StraightFlush(_) => 1,
        FourOfAKind(_) => 2,
        FullHouse(_, _) => 3,
        Flush => 4,
        Straight(_) => 5,
        ThreeOfAKind(_) => 6,
        TwoPair(_, _) => 7,
        OnePair(_) => 8,
        HighCard(_) => 9
    }
}

#[derive(Eq, PartialEq, Debug)]
enum Suit {
    Club,
    Heart,
    Spade,
    Diamond
}

#[cfg(test)]
mod my_tests {
    use crate::{Card, HandType, Suit};

    #[test]
    fn cards_made_right() {
        let card_1 = Card::new("1S");
        assert_eq!(card_1.suit, Suit::Spade);
        assert_eq!(card_1.val, 1);

        let card_2 = Card::new("QH");
        assert_eq!(card_2.suit, Suit::Heart);
        assert_eq!(card_2.val, 12);
    }

    #[test]
    fn straight_flush() {
        let hand1 = HandType::new("6S 2S 3S 4S 5S");
        assert_eq!(hand1, HandType::StraightFlush(6));
    }

}