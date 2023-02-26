module GuessingGame

let reply (guess: int): string =
    match guess with
    | 42 -> "Correct"
    | n when abs (n-42) = 1 -> "So close"
    | n when n < 41 -> "Too low"
    | _ -> "Too high"
    // I originally Made this explicit as wildcard-matching is apparently bad practice since it prevent exhastiveness-checking,
    // though in this case the `when` clauses aren't picked up anyway, and Exercism
    // rejects the submission due to the warning.
