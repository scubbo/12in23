module BirdWatcher

// https://stackoverflow.com/a/4676817/1040915
let everyNthWithOffset(n: int) (offset: int) (elems: 'T[]): 'T[] =
  elems
  |> Array.mapi( fun i e -> if i % n = (n+offset % n) then Some(e) else None)
  |> Array.choose(id)
  
let lastWeek: int[] =
   [| 0; 2; 5; 3; 7; 8; 4|]

let yesterday(counts: int[]): int =
  counts[5]

let total(counts: int[]): int =
  Array.sum counts

let dayWithoutBirds(counts: int[]): bool =
  counts |> Array.exists (fun c -> c = 0)

let incrementTodaysCount(counts: int[]): int[] =
 counts[6] <- counts[6] + 1
 counts

let oddWeek(counts: int[]): bool =
  // ? not sure what's wrong with this - but attempts to printfn or Console.WriteLine
  // did not work (perhaps because the testing environment captures them?), and there's
  // no debugger, so not sure how to debug...
  //
  // counts
  // |> everyNthWithOffset 2 1
  // |> Seq.forall(fun e -> e = 0)
  // ||
  // counts
  // |> everyNthWithOffset 2 1
  // |> Seq.forall(fun e -> e = 10)
  // ||
  // counts
  // |> everyNthWithOffset 2 0
  // |> Seq.forall(fun e -> e = 5)
  
  // These definitions are _wrong_ - the "even" values of an array should be those
  // with even index!
  match counts with
  | [| _; 0; _; 0; _; 0; _ |] -> true
  | [| _; 10; _; 10; _; 10; _ |] -> true
  | [| 5; _; 5; _; 5; _; 5 |] -> true
  | _ -> false
  

