module RobotSimulator

type Direction = North | East | South | West
type Position = int * int

type Robot = { Direction: Direction; Position: Position }

let create direction position = 
    { Direction = direction; Position = position }

let rotateR = function
    | North -> East
    | East -> South
    | South -> West
    | West -> North

let dir = function
    | North -> 0, 1
    | East -> 1, 0
    | South -> 0, -1
    | West -> -1, 0

let step direction (x, y) =
    let dx, dy = dir direction
    x+dx, y+dy

let move instructions robot = 
    let folder r = function 
        | 'R' -> { r with Direction = rotateR r.Direction }
        | 'L' -> { r with Direction = (rotateR >> rotateR >> rotateR) r.Direction }
        | 'A' -> { r with Position = step r.Direction r.Position }
        | c -> failwithf "illegal instruction %A" c
    Seq.fold folder robot instructions
