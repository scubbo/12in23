object ScrabbleScore {

    val LOOKUP: Map<Set<String>, Int> = mapOf(
        setOf("a", "e", "i", "o", "u", "l", "n", "r", "s", "t") to 1,
        setOf("d", "g") to 2,
        setOf("b", "c", "m", "p") to 3,
        setOf("f", "h", "v", "w", "y") to 4,
        setOf("k") to 5,
        setOf("j", "x") to 8,
        setOf("q", "z") to 10
    )

    fun scoreLetter(c: Char): Int {
        for (key in LOOKUP.keys) {
            if (c.lowercase() in key) {
                return LOOKUP.getOrDefault(key, 0)
            }
        }
        return 0;
    }

    fun scoreWord(word: String): Int {
        return word.map{ scoreLetter(it) }.sum();
    }
}
