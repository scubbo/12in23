pub fn verse(n: u32) -> String {
    format!("{}.\n{}.\n", first_line(n), second_line(n))
}

fn first_line(n: u32) -> String {
    let xb = x_bottles_of_beer(n);
    let lower_xb = xb.to_lowercase(); // For 0-case
    format!("{xb} on the wall, {lower_xb}")
}

fn x_bottles_of_beer(n: u32) -> String {
    match n {
        0 => format!("No more bottles of beer"),
        1 => format!("1 bottle of beer"),
        _ => format!("{n} bottles of beer")
    }
}

fn second_line(n: u32) -> String {
    match n {
        0 => String::from("Go to the store and buy some more, 99 bottles of beer on the wall"),
        1 => String::from("Take it down and pass it around, no more bottles of beer on the wall"),
        2 => String::from("Take one down and pass it around, 1 bottle of beer on the wall"),
        _ => {
            let less_xb = x_bottles_of_beer(n-1);
            format!("Take one down and pass it around, {less_xb} on the wall")
        }
    }
}

pub fn sing(start: u32, end: u32) -> String {
    (end..start+1).rev().map(verse).collect::<Vec<String>>().join("\n")
}
