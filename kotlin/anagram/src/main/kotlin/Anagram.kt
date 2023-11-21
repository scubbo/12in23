class Anagram(baseString: String) {
    val baseString = baseString;
    val counts = letterCount(baseString);

    fun match(anagrams: Collection<String>): Set<String> {
        return anagrams.filter { letterCount(it) == counts }.filter { it.lowercase() != baseString.lowercase() }.toSet()
    }

    private fun letterCount(s: String): Map<String, Int> {
        val counts: MutableMap<String, Int> = mutableMapOf()
        for (letter in s) {
            counts.put(letter.lowercase(), counts.getOrDefault(letter.lowercase(), 0) + 1)
        }
        return counts;
    }
}
