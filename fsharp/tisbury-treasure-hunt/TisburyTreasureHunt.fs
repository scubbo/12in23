module TisburyTreasureHunt

let getCoordinate (line: string * string): string =
    snd line

let convertCoordinate (coordinate: string): int * char = 
    (int (coordinate.Substring(0,1)), char (coordinate.Substring(1, 1)))

let compareRecords (azarasData: string * string) (ruisData: string * (int * char) * string) : bool =
     match (azarasData, ruisData) with
     | ((_, a), (_, b, _)) when convertCoordinate a = b -> true
     | _ -> false

let createRecord (azarasData: string * string) (ruisData: string * (int * char) * string) : (string * string * string * string) =
    match (azarasData, ruisData) with
    | ((treasure, coord), (location, split_coord, quadrant)) when convertCoordinate coord = split_coord -> (coord, location, quadrant, treasure)
    | _ -> ("", "", "", "")
