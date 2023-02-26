module AnnalynsInfiltration

// Strange that F#'s taken the C-like "&&" and "||", but used Pythonic/Rubyist "not"
let canFastAttack (knightIsAwake: bool): bool = not knightIsAwake

let canSpy (knightIsAwake: bool) (archerIsAwake: bool) (prisonerIsAwake: bool): bool =
    knightIsAwake || archerIsAwake || prisonerIsAwake

let canSignalPrisoner (archerIsAwake: bool) (prisonerIsAwake: bool): bool =
    prisonerIsAwake && (not archerIsAwake)

let canFreePrisoner (knightIsAwake: bool) (archerIsAwake: bool) (prisonerIsAwake: bool) (petDogIsPresent: bool): bool =
    if petDogIsPresent then
        not archerIsAwake
    else
        prisonerIsAwake && not (knightIsAwake || archerIsAwake)
