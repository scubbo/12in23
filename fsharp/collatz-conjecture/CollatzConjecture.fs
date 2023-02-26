module CollatzConjecture

let steps (number: int): int option =
    if number < 1 then
        None
    else
        let rec iSteps (number: int) (acc: int): int =
            match number with
            | 1 -> acc
            | n when n%2=0 -> iSteps (n/2) (acc+1)
            | n -> iSteps (3*n+1) (acc+1)
        Some(iSteps number 0)
