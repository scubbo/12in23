module Hamming

let distance (strand1: string) (strand2: string): int option =
    // if strand1.Length <> strand2.Length then
    //     None
    // else
    //     // Ugly as sin, but we haven't yet been introduced to the `|>` syntax I see in other solutions 
    //     Some (List.filter (fun (a, b) -> not (a.Equals(b))) (List.zip (Seq.toList(strand1)) (Seq.toList(strand2)))).Length

    // I feel like the following should be workable, but am getting a type error
    if strand1.Length <> strand2.Length then
        None
    else
        let rec inner_distance (strand_list1: (char)List) (strand_list2: (char)List) (accum: int): int =
            match (strand_list1, strand_list2) with
            | head1::tail1, head2::tail2 ->
                let new_accum = if head1.Equals(head2) then accum else (accum + 1)
                inner_distance tail1 tail2 new_accum
            | _, _ -> accum
        Some(inner_distance (Seq.toList strand1) (Seq.toList strand2) 0)
