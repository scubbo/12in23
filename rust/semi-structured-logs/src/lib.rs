// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

use crate::LogLevel::{Error, Info, Warning};

/// various log levels
#[derive(Clone, PartialEq, Eq, Debug)]
pub enum LogLevel {
    Info,
    Warning,
    Error,
}
/// primary function for emitting logs
pub fn log(level: LogLevel, message: &str) -> String {
    let prefix = match level {
        Info => "INFO",
        Warning => "WARNING",
        Error => "ERROR"
    };
    "[".to_owned() + prefix + "]: " + message
}
pub fn info(message: &str) -> String {
    log(Info, message)
}
pub fn warn(message: &str) -> String {
    log(Warning, message)
}
pub fn error(message: &str) -> String {
    log(Error, message)
}
