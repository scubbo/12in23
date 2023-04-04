use std::ops::Add;
use std::time::Duration;
use time::PrimitiveDateTime as DateTime;

const GIGASECOND: Duration = Duration::new(1_000_000_000, 0);

// Returns a DateTime one billion seconds after start.
pub fn after(start: DateTime) -> DateTime {
    start + GIGASECOND
}
