Thoughts about Rust:

## Positives

* Proper integration with IntelliJ (including ability to run tests) is a nice luxury to return to after working in Fsharp!
* Built-in documentation-from-comments is a nice feature (reminiscant of Python!)

## Negatives

* (Minor, subjective) another language with implicit returns? This craze has really taken hold, huh?
* Required semi-colons feels really old-fashioned now!
* The inability to multiple an integer by a float is _wild_. I...guess?...it is a sensible level of type-safety if you're working in memory? Feels really awkward for these demo questions, though I can imagine it makes more sense when used in production.
* No fricking idea why you can't just `+` strings, and instead have to call `.to_owned()` on the left one - guess that'll make sense later...
* Defining the field-types and the methods of a struct separately feels odd. Wonder why that choice was made?
  * Ohhh, looks like it's so that you can define methods on a struct elsewhere from where it's defined. E.g. when defining a Simple Linked List, you can define `impl<T> From<SimpleLinkedList<T>> for Vec<T>` to add `Vec::From...`. That's cool. Not sure that's actually any more helpful or intuitive than just implementing `To` on the struct you're defining, but I bet I'll be proven wrong!
* I've been spoiled by FSharp - I tried to do:
```
match val {
  ...
} + " " + logMessage
```
* Little bit strange that you have to use a macro to initialize a list instead of that just being built-in to the language?
* I guess using `|...|` to indicate arguments of a lambda is...fine.

## Exercism criticisms
Traits (I guess that's what they're called? The `#[...]` things) were introduced without explanation - and they need a _lot_ of explanation, especially given that they're not independent (i.e. adding one requires you add others)
* And Macros, too. And and, the `short-fibonacci` doesn't actually explain what Macros are or how to use them.
* The solution to Resistor colour (at least, most of the solutions I saw) relied on Results, which are not introduced

## Notes

* The "items" terminology (_functions are items_ - though presumably other things are, too?) is going to take some
    getting used to!
* `let var = 10;` requires a type annotation? Blech. It's a goddamn `int`, you savages :P