

fun transcribeToRna(dna: String): String {
    val lookup: Map<Char, Char> = mapOf('G' to 'C', 'C' to 'G', 'T' to 'A','A' to 'U');
    return dna.map{ lookup[it] }.joinToString("")
}
