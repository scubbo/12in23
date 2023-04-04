pub fn production_rate_per_hour(speed: u8) -> f64 {
    success_rate(speed) * 221.0 * (speed as f64)
}

fn success_rate(speed: u8) -> f64 {
    match speed {
        1 => 1.0,
        2 => 1.0,
        3 => 1.0,
        4 => 1.0,
        5 => 0.9,
        6 => 0.9,
        7 => 0.9,
        8 => 0.9,
        9 => 0.77,
        10 => 0.77,
        _ => 0.0
    }

}

pub fn working_items_per_minute(speed: u8) -> u32 {
    (production_rate_per_hour(speed) / (60 as f64)) as u32
}
