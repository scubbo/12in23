use crate::CalculatorInput::Value;

#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32),
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {
    let mut vec: Vec<i32> = Vec::new();
    for inp in inputs {
        match inp {
            Value(v) => vec.push(*v),
            _ => {
                let second = vec.pop();
                let first = vec.pop();
                match (first, second, inp) {
                    (None, None, _) => return None,
                    (Some(_), None, _) => return None,
                    (Some(f), Some(s), CalculatorInput::Add) => vec.push(f + s),
                    (Some(f), Some(s), CalculatorInput::Subtract) => vec.push(f - s),
                    (Some(f), Some(s), CalculatorInput::Multiply) => vec.push(f * s),
                    (Some(f), Some(s), CalculatorInput::Divide) => vec.push(f/s),
                    (None, Some(_), _) => {} // Cannot actually happen, but compiler doesn't know that
                    (Some(_), Some(_), Value(_)) => {} // Ditto
                }

            }
        }
    }
    return if vec.len() != 1 {
        None
    } else {
        Some(vec.pop().unwrap())
    }
}
