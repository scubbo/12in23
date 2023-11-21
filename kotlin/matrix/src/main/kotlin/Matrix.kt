class Matrix(private val matrixAsString: String) {

    val rows = buildRows(matrixAsString);

    fun column(colNr: Int): List<Int> {
        return rows.map { it[colNr-1] }
    }

    fun row(rowNr: Int): List<Int> {
        return rows[rowNr-1]
    }

    fun buildRows(inpString: String): List<List<Int>> {
        return inpString.split('\n').map { it.split(' ').map { it.toInt() } }
    }
}
