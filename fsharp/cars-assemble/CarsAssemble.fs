module CarsAssemble

let successRate (speed: int): float =
    if speed = 0 then
        0.
    elif speed < 5 then
        1.
    elif speed < 9 then
        0.90
    elif speed = 9 then
        0.80
    else
        0.77 // In real life we'd do bounds checking

let productionRatePerHour (speed: int): float =
    float(speed * 221) * successRate speed

let workingItemsPerMinute (speed: int): int =
    int((productionRatePerHour speed)/60.)
