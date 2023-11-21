I haven't done a great job of keeping notes in languages as I go! Restarting this on 2023-07-06.

I am really not loving Lisp so far. A lot of irritations that seem:
* The "One form" style makes it really awkward to do some otherwise very reasonable things. Ironically enough, list-processing itself is one of the trickiest things - you have to abuse some (to me) quite esoteric (though admittedly powerful) processing techniques in order to implement the algorithm in "one pass" in order to avoid what would in other language simply be"_declare the list, iterate over it doing something, **and then do something else**_"
* Differing equality checkers (`=`/`eq`, `string=`/`string-equal`) seems like it's just asking for trouble
* The REPL is rather user-unfriendly (What the hell is a "bogus stack frame"!?), to say nothing of the error messages. I actually had to write a script (`lt.sh`) to run tests in a reliable way :P

Maybe this is a language you really need to immerse yourself in in order to see the benefits. Sadly, I'm already at capacity (Rust) for "_new languages to get more serious than just dabbling-in_".