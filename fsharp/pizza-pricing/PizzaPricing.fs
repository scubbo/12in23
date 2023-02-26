module PizzaPricing

type Pizza =
    | Margherita
    | Caprese
    | Formaggio
    | ExtraSauce of b: Pizza
    | ExtraToppings of b: Pizza

let rec pizzaPrice (pizza: Pizza): int =
    match pizza with
    | Margherita -> 7
    | Caprese -> 9
    | Formaggio -> 10
    | ExtraSauce b -> 1 + pizzaPrice b
    | ExtraToppings b -> 2 + pizzaPrice b

let orderPrice(pizzas: Pizza list): int =
    let basePrice = pizzas |> List.map pizzaPrice |> List.sum
    match pizzas.Length with
    | 1 -> basePrice + 3
    | 2 -> basePrice + 2
    | _ -> basePrice
