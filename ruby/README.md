Ah, Ruby, my old "friend".

## Things I like:
* methods ending in `?` or `!` as a convention for Boolean returns or for mutation is nice
* Negative indexing (like in Python)
* Nice array-processing methods (`.count`, `.any?`, `.select`, etc.)` - better than Python's since these are chainable!
* Multiple Assignment and Decomposition (`a, *middle, b = [1, 2, 3, 4, 5]`)
  * Composition in method parameters (again, Python-like)

## Things I dislike
* The existence of `unless` is _more_ confusing. `if not` is equivalent, stop taking up mindspace!
* Implicit returns, though I'm coming around to that being not-awful
* The ability to call methods without parens around the arguments is much more confusing than it is aesthetic. Is `foo bar baz` equivalent to `foo(bar, baz)` or `foo(bar(baz))`?
  * This is _particularly_ confusing for block-methods which are such a key part of Ruby!
  * I can't remember if this is Ruby or Scala, but `method` being different from `method()` is even worse!
* No type annotations
* This is a "I don't understand this yet" rather than a "this is a thing I dislike", but WTF is the point in symbols?
* 'string' and "string" appear to be different? (Interpolation doesn't work in the former)
* The use of `@name` for object fields is a little weird, but I could get used to that. Hard to say which is less-bad of that and Python's ubiquitous `self.` - though at least the latter is explicit.
* (Minor, but) `elsif` is pointless - just `elif`!
