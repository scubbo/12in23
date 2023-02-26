module ValentinesDay

type Approval = Yes | No | Maybe

type Cuisine = Korean | Turkish

type Genre = Crime | Horror | Romance | Thriller
// TODO: please define the 'Activity' discriminated union type
type Activity =
    | BoardGame
    | Chill
    | Movie of Genre
    | Restaurant of Cuisine
    | Walk of int

let rateActivity (activity: Activity): Approval =
    match activity with
    | BoardGame -> No
    | Chill -> No
    | Movie g -> if g.Equals(Romance) then Yes else No
    | Restaurant c -> if c.Equals(Korean) then Yes else Maybe
    | Walk d ->
        if d < 3 then Yes else
            if d < 5 then Maybe else No
