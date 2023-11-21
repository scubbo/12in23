## Thoughts on bash

A lot of my difficulties in using this language stem from the inconsistent ways of referring to a variable. E.g. it's necessary to prefix a variable name with `$` to refer to its value:

```
$ my_string="hello world"
$ echo $my_string
hello world
```

...except when you're doing string substitutions or substringing

```
$ echo ${my_string/"hello"/"goodbye"}
goodbye world
$ echo ${$my_string/"hello"/"goodbye"}
bash: ${$my_string/"hello"/"goodbye"}: bad substitution
$ echo ${my_string:0:5}
hello
$ echo ${$my_string:0:5}
bash: ${$my_string:0:5}: bad substitution
```

which would be ok if there was a consistent rule that "_only use a dollar-prefix while outside the scope of a dollar-initiatied block; dollar-prefixing is illegal inside such a scope_", but there is no such rule:

```
$ num1="1"
$ num2="2"
$ echo $(( num1 + num2 ))
3
$ echo $(( $num1 + $num2 ))
3
```

nor is it the case that you _never_ have to use a dollar-prefix within a dollar-initiated block:

```
$ my_string="hello"
$ echo $my_string
$ my_longer_string=$(echo $my_string" world")
$ echo $my_longer_string
hello world
$ my_incorrect_string=$(echo my_string" world")
$ echo $my_incorrect_string
my_string world
```

(that last case is particularly egregious - `foo` is _not_ the same thing as `"foo"`, and supporting unquoted literal strings with identical syntax to variable reference is asking for typo-based trouble).

## String manipulation

### Pattern substitution

```
$ echo ${"hello world"/"hello"/"goodbye"}
bash: ${"hello world"/"hello"/"goodbye"}: bad substitution
```

Hmm, that's weird, bash can't perform pattern substitution on a string literal. Odd, but probably not a restriction that would ever come up in real uses where you'd probably always be working with variables, so fair enough.

```
my_string="hello world"
$ echo ${my_string/"hello"/"goodbye"}
goodbye world
$ echo ${my_string/"l"/"w"}
hewlo world
```

TODO: check that I've remembered Perl's flags correctly!

OK, so pattern substitution only changes the first match. I would guess that bash predates vim and Perl, but let's try the standard "/g" flag for a global replace:

```
$ echo ${my_string/"l"/"w"/g}
hew/glo world
```

Ok, so that just parsed `"w"/g` as the replacement string. That's in-keeping with Bash's inconsistent attitude to variable delimiters, I guess. Let's check the docs...

```
${parameter/pattern/string}
    Pattern substitution.  The pattern is expanded to produce a pattern just as in pathname expansion, Parameter is expanded and the longest match
    of pattern against its value is replaced with string.  The match is performed using the rules described under Pattern Matching below.  If pat-
    tern begins with /, all matches of pattern are replaced with string.  Normally only the first match is replaced.  If pattern begins with #, it
    must  match  at the beginning of the expanded value of parameter.  If pattern begins with %, it must match at the end of the expanded value of
    parameter.  If string is null, matches of pattern are deleted and the / following pattern may be omitted.  If the nocasematch shell option  is
    enabled,  the  match  is performed without regard to the case of alphabetic characters.  If parameter is @ or *, the substitution operation is
    applied to each positional parameter in turn, and the expansion is the resultant list.  If parameter is an array variable subscripted  with  @
    or *, the substitution operation is applied to each member of the array in turn, and the expansion is the resultant list.
```

OK, so...

```
$ echo ${my_string/"/l"/"w"}
hello world
```

Hmm. That didn't work.

Wait. I wonder if...

```
$ echo ${my_string//"l"/"w"}
hewwo worwd
```
I am going to go fucking insane.

TODO:

## Quoting/Expansion

https://stackoverflow.com/a/18710850/1040915 - regex matching acts differently depending on whether it's in a variable or not.

## For-looping to variables

Can't do `for idx in {0..$var}`, have to do `$(eval echo {0..$var})`