

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    let height = minefield.len();
    if height == 0 {
        return vec![String::from(""); 0];
    }

    let width = minefield[0].len();
    if width == 0 {
        return vec![String::from(""); height];
    }

    let mut out = vec![vec![b' '; width]; height];
    for (y, row) in minefield.iter().enumerate() {
        for (x, char) in row.as_bytes().iter().enumerate() {
            if *char == b'*' {
                // Lock in the mine
                out[y][x] = b'*';
                // Why do I have to declare this pointer to be mut, when `out` itself is mut?
                spread(&mut out, x as i32, y as i32, width as i32, height as i32);
            }
        }
    }
    out.iter().map(
        // Turn a vector of u8s into a vector of chars, then collect to a String
        |u8s| u8s.into_iter().map(|c| *c as char).collect()
    ).collect()
}

fn spread(out: &mut Vec<Vec<u8>>, x: i32, y: i32, width: i32, height: i32) -> () {
    // Cannot make this `const` because "Allocation not allowed in constants". I guess this is because
    // under-the-hood the `vec!` is actually calling `Vec::new(); v.push()`?
    let neighbour_moves: Vec<(i32, i32)> = vec![
        (1, 0), (0, 1), (-1, 0), (0, -1),
        (1, 1), (1, -1), (-1, 1), (-1, -1)
    ];

    neighbour_moves.iter().map(|shift| (shift.0 + x, shift.1 + y))
        .filter(|cell| cell.0 >= 0 && cell.0 < width && cell.1 >= 0 && cell.1 < height)
        .for_each(|cell| out[cell.1 as usize][cell.0 as usize] = increment(&mut (out[cell.1 as usize][cell.0 as usize])));
}

fn increment(val: &mut u8) -> u8 {
    match val {
        b' ' => b'1',
        b'*' => b'*',
        x => {
            *x + 1
            // Thanks, I hate it.
            // ((*x as char).to_digit(10).unwrap() + 1).to_string().chars().next().unwrap() as u8
        }
    }
}

// I couldn't find a way for `increment` to just modify the value in-place - I got
// "Cannot assign twice to immutable variable" in the commented-out `increment_in_place`
// below, despite declaring `val` as `mut`. Is this possible? My current approach seems
// prone to typos - the indices on one side of the assignment must match those on the other.

// fn increment_in_place(val: &mut u8) -> () {
//     match val {
//         b' ' => val = b'1',
//         x => {val = ((*x as char).to_digit(10).unwrap() + 1).to_string().chars().next().unwrap() as u8}
//     };
// }