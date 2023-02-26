Use JetBrains Rider with the F# plugin to write F# code. It doesn't seem to be able to cope with multiple modules (it calls them "solutions"?) open at once, so open a Rider instance at the level of the exercise.

## Things I like about F#

* Pattern-matching is very nice!
* "Everything is a statement" leads to some nice uses like assigning from the "output" of a match or an if
* Using `;` as delimiters in lists and arrays is a little weird, though I like the syntax of `[| ... |]` to denote arrays - evokes their fixed size clearly!
* The type system has been fluid enough to do everything I've wanted to do so far (looking at you, TypeScript...), though I admittedly that's been limited to Exercism exercises...
* The style guides pretty clear and reasonable - especially given how prevalent piping and long match clauses will be, it's very reasonable to define indentation there (actually I think it's whitespace significant?)

## Things I don't like about F#

* A nitpick, but capital-case methods feels weird. Very .NET!
* Paren-less comma-less method invocations are _weird_ (and, I claim less subjectively, ambiguous). I expect there will be an "aha!" moment when I see the Light of Curry and it all becomes beautifully clear - but I'm not there yet
* A tooling issue rather than a language one - lack of IntelliJ compatibility is annoying (and Rider is only free for month). I bet Visual Studio probably does better.
* Single equals for equality-comparison feels like it's just asking for trouble (I'm sure you can rigorously prove there are no cases where confusion is possible)
* I'm still getting used to implicit returns (I don't like it in Ruby, either), but I can see the usefulness and compatibility with "everything is a statement"
* Lack of String Interpolation