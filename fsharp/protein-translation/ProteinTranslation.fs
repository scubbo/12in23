module ProteinTranslation

let is_not_stop_codon codon: bool =
    match codon with
    | [|'U'; 'A'; 'A'|] -> false
    | [|'U'; 'A'; 'G'|] -> false
    | [|'U'; 'G'; 'A'|] -> false
    | _ -> true
    
let codon_to_protein codon: string =
    match codon with
    | [|'A'; 'U'; 'G'|] -> "Methionine"
    | [|'U'; 'U'; 'U'|] -> "Phenylalanine"
    | [|'U'; 'U'; 'C'|] -> "Phenylalanine"
    | [|'U'; 'U'; 'A'|] -> "Leucine"
    | [|'U'; 'U'; 'G'|] -> "Leucine"
    | [|'U'; 'C'; 'U'|] -> "Serine"
    | [|'U'; 'C'; 'C'|] -> "Serine"
    | [|'U'; 'C'; 'A'|] -> "Serine"
    | [|'U'; 'C'; 'G'|] -> "Serine"
    | [|'U'; 'A'; 'U'|] -> "Tyrosine"
    | [|'U'; 'A'; 'C'|] -> "Tyrosine"
    | [|'U'; 'G'; 'U'|] -> "Cysteine"
    | [|'U'; 'G'; 'C'|] -> "Cysteine"
    | [|'U'; 'G'; 'G'|] -> "Tryptophan"
    | _ -> failwith "Unsupported codon"

let proteins (rna: string) =
    rna
    |> Seq.chunkBySize 3
    |> Seq.takeWhile is_not_stop_codon
    |> Seq.map codon_to_protein
    |> Seq.toList