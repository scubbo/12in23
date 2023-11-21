class Triangle<out T : Number>(val a: T, val b: T, val c: T) {

    val isEquilateral: Boolean = a == b && b == c;
    val isIsosceles: Boolean = (
        (a == b && a != c) ||
        (a == c && a != b) ||
        (b == c && a != b) ||
        (a == b && b == c) // Equilateral triangles are also isosceles
    );
    val isScalene: Boolean = (a != b && b != c && a != c)

    init {
        // Triangles have positive side-length
        if (a == 0 || b == 0 || c == 0) {
            throw IllegalArgumentException("");
        }
        val sideA = a.toDouble();
        val sideB = b.toDouble();
        val sideC = c.toDouble();

        // Triangle inequality
        require(sideA + sideB > sideC);
        require(sideB + sideC > sideA);
        require(sideC + sideA > sideB);
    }
    
}
