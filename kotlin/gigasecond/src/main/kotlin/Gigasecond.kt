import java.time.LocalDateTime
import java.time.LocalDate
import java.time.Instant

class Gigasecond(inpDate: LocalDateTime) {

    val date: LocalDateTime = inpDate.plusSeconds(1_000_000_000)

    constructor(inpDate: LocalDate) : this(inpDate.atStartOfDay())
}
