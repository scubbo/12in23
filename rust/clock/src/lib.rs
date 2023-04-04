use std::fmt;

#[derive(Eq,PartialEq,Debug)]
pub struct Clock {
    pub hours: i32,
    pub minutes: i32
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let mut new_hours = hours;
        let mut new_minutes = minutes;
        if new_minutes >= 60 {
            new_hours += new_minutes / 60;
        } else {
            // new_minutes < 0
            while new_minutes < 0 {
                new_minutes += 60;
                new_hours -= 1;
            }
        }
        // Rust's modulus operator does not work like Python's on negative numbers,
        // so we need to incrementally increase until it's positive...
        while new_hours < 0 {
            new_hours += 24;
        }
        Clock{hours: new_hours % 24, minutes: new_minutes % 60}
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Clock::new(self.hours, self.minutes + minutes)
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match (self.hours, self.minutes) {
            (24, _) => write!(f, "{:0>2}:{:0>2}", 0, self.minutes),
            _ => write!(f, "{:0>2}:{:0>2}", self.hours, self.minutes)
        }

    }
}
