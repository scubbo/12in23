import kotlin.text.Regex

class PhoneNumber(inp: String) {

    val number: String? = process(inp);

    private fun process(inpString: String): String? {
        var stripped = Regex("[^0-9]").replace(inpString, "")
        if (stripped[0] == '1') {
            stripped = stripped.substring(1)
        }
        if (stripped.length != 10) {
            throw IllegalArgumentException("");
        }
        if (stripped[0] == '0' || stripped[0] == '1' || stripped[3] == '0' || stripped[3] == '1') {
            throw IllegalArgumentException("")
        }
        return stripped;
    }
}
