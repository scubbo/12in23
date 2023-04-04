use int_enum::IntEnum;
use enum_iterator::all;
use enum_iterator::Sequence;

#[derive(Debug, PartialEq, Eq, IntEnum, Copy, Clone, Sequence)]
#[repr(u32)]
pub enum ResistorColor {
    Black = 0,
    Brown = 1,
    Red = 2,
    Orange = 3,
    Yellow = 4,
    Green = 5,
    Blue = 6,
    Violet = 7,
    Grey = 8,
    White = 9

}

pub fn color_to_value(color: ResistorColor) -> u32 {
    color.int_value()
}

pub fn value_to_color_string(value: u32) -> String {
    return match ResistorColor::from_int(value) {
        Ok(val) => format!("{:?}", val),
        Err(_) => String::from("value out of range")
    }
}

pub fn colors() -> Vec<ResistorColor> {
    all::<ResistorColor>().collect::<Vec<_>>()
}
