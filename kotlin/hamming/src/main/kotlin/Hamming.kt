object Hamming {

    fun compute(leftStrand: String, rightStrand: String): Int {
        val leftLength = leftStrand.length
        if (leftLength != rightStrand.length) {
            throw IllegalArgumentException("left and right strands must be of equal length")
        }
        var diff = 0;
        for (i in 0..leftLength-1) {
            if (leftStrand[i] != rightStrand[i]) {
                diff++
            }
        }
        return diff;
    }
}
