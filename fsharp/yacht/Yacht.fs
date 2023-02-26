module Yacht

type Category = 
    | Ones
    | Twos
    | Threes
    | Fours
    | Fives
    | Sixes
    | FullHouse
    | FourOfAKind
    | LittleStraight
    | BigStraight
    | Choice
    | Yacht

type Die =
    | One 
    | Two 
    | Three
    | Four 
    | Five 
    | Six
        

let valueOfDie (value_as_type: Die): int =
    // I suspect there's a way to do this by attaching properties to
    // the types of the DUT Die, but I can't figure out how to do this
    match value_as_type with
    | One ->    1
    | Two ->    2
    | Three ->  3
    | Four ->   4
    | Five ->   5
    | Six ->    6

let countAndMultiplyDiceOfType (value_as_type: Die) (dice): int =
    let value = valueOfDie value_as_type 
    List.filter (fun i -> i = value_as_type) dice |> List.map (fun i -> value) |> List.sum

let testFullHouse dice: int =
    let sortedCountsOfDice =
        List.countBy (fun i -> i) dice
        |> List.map (fun elem -> snd elem)
        |> List.sortDescending
    match sortedCountsOfDice with
    | 3 :: 2 :: _ -> List.map (valueOfDie) dice |> List.sum
    | _ -> 0

let testFourOfAKind dice: int =
    let sortedCountsOfDice =
        List.countBy (fun i -> i) dice
        |> List.sortByDescending (fun (key, count) -> count)
    match sortedCountsOfDice with
    | head :: _ when snd head >= 4 -> 4 * valueOfDie (fst head)
    | _ -> 0

let testLittleStraight dice: int =
    match List.map valueOfDie dice |> List.sort with
    | [1; 2; 3; 4; 5] -> 30
    | _ -> 0

let testBigStraight dice: int =
    match List.map valueOfDie dice |> List.sort with
    | [2; 3; 4; 5; 6] -> 30
    | _ -> 0

let testChoice dice: int =
    List.map valueOfDie dice |> List.sum

let testYacht dice: int =
    let sortedCountsOfDice =
        List.countBy (fun i -> i) dice
        |> List.sortByDescending (fun (key, count) -> count)
    match sortedCountsOfDice with
    | head :: tail when snd head = 5 -> 50
    | _ -> 0
    
let score category dice =
    match category with
    | Ones -> countAndMultiplyDiceOfType One dice
    | Twos -> countAndMultiplyDiceOfType Two dice
    | Threes -> countAndMultiplyDiceOfType Three dice
    | Fours -> countAndMultiplyDiceOfType Four dice
    | Fives -> countAndMultiplyDiceOfType Five dice
    | Sixes -> countAndMultiplyDiceOfType Six dice
    | FullHouse -> testFullHouse dice
    | FourOfAKind -> testFourOfAKind dice
    | LittleStraight -> testLittleStraight dice
    | BigStraight -> testBigStraight dice
    | Choice -> testChoice dice
    | Yacht -> testYacht dice